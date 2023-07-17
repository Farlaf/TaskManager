import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles(() => ({
  modal: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    outline: 0,
  },

  root: {
    width: 465,
  },

  actions: {
    display: 'flex',
    justifyContent: 'flex-end',
  },

  form: {
    display: 'flex',
    flexDirection: 'column',
  },
}));

export default useStyles;
