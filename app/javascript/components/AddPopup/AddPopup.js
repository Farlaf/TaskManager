import React, { useState } from 'react';
import PropTypes from 'prop-types';
import { has } from 'ramda';

import TaskForm from 'forms/TaskForm';
import useStyles from './useStyles';

import { Modal, Button, Card, CardActions, CardContent, IconButton, TextField, CardHeader } from '@material-ui/core';
import CloseIcon from '@material-ui/icons/Close';
import TaskPresenter from 'presenters/TaskPresenter';

function AddPopup({ onClose, onCardCreate }) {
  const [task, changeTask] = useState(TaskForm.defaultAttributes());
  const [isSaving, setSaving] = useState(false);
  const [errors, setErrors] = useState({});
  const handleCreate = () => {
    setSaving(true);

    onCardCreate(task).catch((error) => {
      setSaving(false);
      setErrors(error || {});

      if (error instanceof Error) {
        alert(`Creation Failed! Error: ${error.message}`);
      }
    });
  };
  const handleChangeTextField = (fieldName) => (event) => changeTask({ ...task, [fieldName]: event.target.value });
  const styles = useStyles();

  return (
    <Modal className={styles.modal} open onClose={onClose}>
      <Card className={styles.root}>
        <CardHeader
          action={
            <IconButton onClick={onClose}>
              <CloseIcon />
            </IconButton>
          }
          title="Add New Task"
        />
        <CardContent>
          <div className={styles.form}>
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
              margin="dense"
            />
          </div>
        </CardContent>
        <CardActions className={styles.actions}>
          <Button disabled={isSaving} onClick={handleCreate} variant="contained" size="small" color="primary">
            Add
          </Button>
        </CardActions>
      </Card>
    </Modal>
  );
}

AddPopup.propTypes = {
  onClose: PropTypes.func.isRequired,
  onCardCreate: PropTypes.func.isRequired,
};

export default AddPopup;
