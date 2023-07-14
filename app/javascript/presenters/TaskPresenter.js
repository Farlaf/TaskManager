import PropTypes from 'prop-types';
import PropTypesPresenter from '../utils/PropTypesPresenter';

export default new PropTypesPresenter({
  id: PropTypes.number,
  name: PropTypes.string,
  description: PropTypes.string,
  author: PropTypes.string,
  assignee: PropTypes.string,
});
