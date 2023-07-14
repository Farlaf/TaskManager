import React from 'react';
import PropTypes from 'prop-types';

import { Card, CardHeader, CardContent, Typography, IconButton } from '@material-ui/core';
import Edit from '@material-ui/icons/Edit';
import useStyles from './useStyles';

import TaskPresenter from 'presenters/TaskPresenter';

function Task({ task, onClick }) {
  const styles = useStyles();

  const handleClick = () => onClick(task);
  const action = (
    <IconButton onClick={handleClick}>
      <Edit />
    </IconButton>
  );

  <CardHeader action={action} title={TaskPresenter.name(task)} />;

  return (
    <Card className={styles.root}>
      <CardHeader action={action} title={TaskPresenter.name(task)} />
      <CardContent>
        <Typography variant="body2" color="textSecondary" component="p">
          {TaskPresenter.description(task)}
        </Typography>
      </CardContent>
    </Card>
  );
}

Task.propTypes = {
  task: TaskPresenter.shape().isRequired,
  onClick: PropTypes.func.isRequired,
};

export default Task;
