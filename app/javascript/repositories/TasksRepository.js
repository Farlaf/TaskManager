import { apiV1TasksPath, apiV1TaskPath, attachImageApiV1TaskPath, removeImageApiV1TaskPath } from 'routes/ApiRoutes';
import FetchHelper from 'utils/fetchHelper';

export default {
  index(params) {
    const path = apiV1TasksPath();
    return FetchHelper.get(path, params);
  },

  show(id) {
    const path = apiV1TaskPath(id);
    return FetchHelper.get(path);
  },

  update(id, task = {}) {
    const path = apiV1TaskPath(id);
    return FetchHelper.put(path, { task });
  },

  create(task = {}) {
    const path = apiV1TasksPath();
    return FetchHelper.post(path, { task });
  },

  destroy(id) {
    const path = apiV1TaskPath(id);
    return FetchHelper.delete(path);
  },

  attach_image(id, attachment) {
    const path = attachImageApiV1TaskPath(id);
    return FetchHelper.putFormData(path, attachment);
  },

  removeImage(id) {
    const path = removeImageApiV1TaskPath(id);
    return FetchHelper.putRemoveImage(path);
  },
};
