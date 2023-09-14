import React from 'react';
import PropTypes from 'prop-types';
import { has, isNil } from 'ramda';

import TextField from '@material-ui/core/TextField';

import useStyles from './useStyles';
import UserSelect from 'components/UserSelect';

import TasksRepository from 'repositories/TasksRepository';
import TaskPresenter from 'presenters/TaskPresenter';
import ImageUpload from 'components/ImageUpload';
import { Button } from '@material-ui/core';

function Form({ errors, onChange, task }) {
  const handleChangeTextField = (fieldName) => (event) => onChange({ ...task, [fieldName]: event.target.value });
  const handleChangeSelect = (fieldName) => (user) => onChange({ ...task, [fieldName]: user });
  const styles = useStyles();

  const onAttachImage = (image) => {
    TasksRepository.attach_image(task.id, image);
  };

  const onRemoveImage = () => {
    TasksRepository.removeImage(task.id);
  };

  return (
    <form className={styles.root}>
      <TextField
        error={has('name', errors)}
        helperText={errors.name}
        onChange={handleChangeTextField('name')}
        value={TaskPresenter.name(task)}
        label="Name"
        required
        margin="dense"
      />
      <TextField
        error={has('description', errors)}
        helperText={errors.description}
        onChange={handleChangeTextField('description')}
        value={TaskPresenter.description(task)}
        label="Description"
        required
        multiline
        margin="dense"
      />
      <UserSelect
        label="Author"
        value={TaskPresenter.author(task)}
        userType="Manager"
        onChange={handleChangeSelect('author')}
        isRequired
        error={has('author', errors)}
        helperText={errors.author}
      />
      <UserSelect
        label="Asignee"
        value={TaskPresenter.assignee(task)}
        userType="Developer"
        onChange={handleChangeSelect('assignee')}
        error={has('assignee', errors)}
        helperText={errors.assignee}
      />
      {isNil(TaskPresenter.imageUrl(task)) ? (
        <div className={styles.imageUploadContainer}>
          <ImageUpload onUpload={onAttachImage} />
        </div>
      ) : (
        <div className={styles.previewContainer}>
          <img className={styles.preview} src={TaskPresenter.imageUrl(task)} alt="Attachment" />
          <Button variant="contained" size="small" color="primary" onClick={onRemoveImage}>
            Remove image
          </Button>
        </div>
      )}
    </form>
  );
}

Form.propTypes = {
  onChange: PropTypes.func.isRequired,
  task: TaskPresenter.shape().isRequired,
  errors: PropTypes.shape({
    name: PropTypes.arrayOf(PropTypes.string),
    description: PropTypes.arrayOf(PropTypes.string),
    author: PropTypes.arrayOf(PropTypes.string),
    assignee: PropTypes.arrayOf(PropTypes.string),
  }),
};

Form.defaultProps = {
  errors: {},
};

export default Form;
