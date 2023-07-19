import PropTypes from 'prop-types';
import PropTypesPresenter from 'utils/PropTypesPresenter';

export default new PropTypesPresenter({
  id: PropTypes.number,
  name: PropTypes.string,
  description: PropTypes.string,
  author: PropTypes.object,
  assignee: PropTypes.object,
  state: PropTypes.string,
  transitions: PropTypes.arrayOf(PropTypes.object),
});
