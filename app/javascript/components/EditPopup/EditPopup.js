import PropTypes from 'prop-types';
import React, { useEffect, useState } from 'react';
import useStyles from './useStyles';
import { isNil } from 'ramda';

import {
  Modal,
  Button,
  Card,
  CardActions,
  CardContent,
  IconButton,
  CircularProgress,
  CardHeader,
} from '@material-ui/core';
import CloseIcon from '@material-ui/icons/Close';
import Form from './components/Form';
import TaskPresenter from 'presenters/TaskPresenter';

function EditPopup({ cardId, onClose, onCardDestroy, onCardLoad, onCardUpdate, onAttachImage, onRemoveImage }) {
  const [task, setTask] = useState(null);
  const [isSaving, setSaving] = useState(false);
  const [errors, setErrors] = useState({});
  const styles = useStyles();

  useEffect(() => {
    onCardLoad(cardId).then(setTask);
  }, []);

  const handleCardUpdate = () => {
    setSaving(true);

    onCardUpdate(task).catch((error) => {
      setSaving(false);
      setErrors(error || {});

      if (error instanceof Error) {
        alert(`Update Failed! Error: ${error.message}`);
      }
    });
  };

  const handleCardDestroy = () => {
    setSaving(true);
    onCardDestroy(task).catch((error) => {
      setSaving(false);

      alert(`Destroy Failed! Error: ${error.message}`);
    });
  };

  const isLoading = isNil(task);

  return (
    <Modal className={styles.modal} open onClose={onClose}>
      <Card className={styles.root}>
        <CardHeader
          action={
            <IconButton onClick={onClose}>
              <CloseIcon />
            </IconButton>
          }
          title={
            isLoading
              ? 'Your task is loading. Please be patient.'
              : `Task # ${TaskPresenter.id(task)} [${TaskPresenter.name(task)}]`
          }
        />
        <CardContent>
          {isLoading ? (
            <div className={styles.loader}>
              <CircularProgress />
            </div>
          ) : (
            <Form
              errors={errors}
              onChange={setTask}
              task={task}
              onAttachImage={onAttachImage}
              onRemoveImage={onRemoveImage}
            />
          )}
        </CardContent>
        <CardActions className={styles.actions}>
          <Button
            disabled={isLoading || isSaving}
            onClick={handleCardUpdate}
            size="small"
            variant="contained"
            color="primary"
          >
            Update
          </Button>
          <Button
            disabled={isLoading || isSaving}
            onClick={handleCardDestroy}
            size="small"
            variant="contained"
            color="secondary"
          >
            Destroy
          </Button>
        </CardActions>
      </Card>
    </Modal>
  );
}

EditPopup.propTypes = {
  cardId: PropTypes.number.isRequired,
  onClose: PropTypes.func.isRequired,
  onCardDestroy: PropTypes.func.isRequired,
  onCardLoad: PropTypes.func.isRequired,
  onCardUpdate: PropTypes.func.isRequired,
  onAttachImage: PropTypes.func.isRequired,
  onRemoveImage: PropTypes.func.isRequired,
};

export default EditPopup;
