import { apiV1UserPath, apiV1UsersPath } from '../routes/ApiRoutes';
import FetchHelper from '../utils/fetchHelper';

export default {
  index(params) {
    const path = apiV1UsersPath();
    return FetchHelper.get(path, params);
  },

  show(id) {
    const path = apiV1UserPath(id);
    return FetchHelper.get(path);
  },
};
