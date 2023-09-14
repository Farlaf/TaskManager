import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles(() => ({
  root: {
    display: 'flex',
    flexDirection: 'column',
  },
  previewContainer: {
    maxHeight: 300,
    maxWidth: 300,
  },
  preview: {
    maxWidth: '100%',
    maxHeight: 300,
  },
}));

export default useStyles;
