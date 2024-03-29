import { useSelector } from 'react-redux';
import { useTasksActions } from 'slices/TasksSlice';
import TaskPresenter, { STATES } from 'presenters/TaskPresenter';
import TaskForm from 'forms/TaskForm';

const useTasks = () => {
  const board = useSelector((state) => state.TasksSlice.board);
  const {
    loadColumn,
    loadColumnMore,
    destroyTask,
    updateTask,
    createTask,
    showTask,
    attachTaskImage,
    removeTaskImage,
  } = useTasksActions();

  const loadBoard = () => Promise.all(STATES.map(({ key }) => loadColumn(key)));

  const loadMoreTasks = (state, page, perPage) => loadColumnMore(state, page, perPage);

  const moveTask = (task, source, destination) => {
    const transition = TaskPresenter.transitions(task).find(({ to }) => destination.toColumnId === to);
    if (!transition) {
      return null;
    }

    return updateTask(TaskPresenter.id(task), { stateEvent: transition.event })
      .then(() => {
        loadColumn(destination.toColumnId);
        loadColumn(source.fromColumnId);
      })
      .catch((error) => {
        alert(`Move failed! ${error.message}`);
      });
  };

  const addTask = (params, handleClose) => {
    const attributes = TaskForm.attributesToSubmit(params);
    return createTask(attributes).then(({ data: { task } }) => {
      loadColumn(TaskPresenter.state(task));
      handleClose();
    });
  };

  const loadTask = (id) => showTask(id);

  const deleteTask = (task, handleClose) =>
    destroyTask(TaskPresenter.id(task)).then(() => {
      loadColumn(TaskPresenter.state(task));
      handleClose();
    });

  const editTask = (task, handleClose) => {
    const attributes = TaskForm.attributesToSubmit(task);

    return updateTask(TaskPresenter.id(task), attributes).then(() => {
      loadColumn(TaskPresenter.state(task));
      handleClose();
    });
  };

  return {
    board,
    loadBoard,
    loadMoreTasks,
    loadTask,
    moveTask,
    addTask,
    deleteTask,
    editTask,
    attachTaskImage,
    removeTaskImage,
  };
};

export default useTasks;
