import { apiV1TasksPath } from '../routes/ApiRoutes';
import FetchHelper from '../utils/fetchHelper';

export default {
  index(params) {
    const path = apiV1TasksPath();
    // const path = 'api/v1/tasks/';
    return FetchHelper.get(path, params);
  },

  show(id) {
    const path = apiV1TasksPath(id);
    return FetchHelper.get(path);
  },

  update(id, task = {}) {
    const path = apiV1TasksPath(id);
    return FetchHelper.put(path, task);
  },

  create(task = {}) {
    const path = apiV1TasksPath();
    return FetchHelper.post(path, task);
  },

  destroy(id) {
    const path = apiV1TasksPath(id);
    return FetchHelper.delete(path);
  },
};
