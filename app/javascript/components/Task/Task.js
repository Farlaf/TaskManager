import React from 'react';
import PropTypes from 'prop-types';

import { Card, CardHeader, CardContent, Typography, IconButton } from '@material-ui/core';
import Edit from '@material-ui/icons/Edit';
import useStyles from './useStyles';

function Task({ task, onClick }) {
  const styles = useStyles();

  const handleClick = () => onClick(task);
  const action = (
    <IconButton onClick={handleClick}>
      <Edit />
    </IconButton>
  );

  <CardHeader action={action} title={task.name} />;

  return (
    <Card className={styles.root}>
      <CardHeader action={action} title={task.name} />
      <CardContent>
        <Typography variant="body2" color="textSecondary" component="p">
          {task.description}
        </Typography>
      </CardContent>
    </Card>
  );
}

Task.propTypes = {
  task: PropTypes.shape().isRequired,
  onClick: PropTypes.func.isRequired,
};

export default Task;
