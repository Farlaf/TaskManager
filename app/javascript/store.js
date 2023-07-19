import { configureStore } from '@reduxjs/toolkit';
import TasksSlice from 'slices/TasksSlice';

const store = configureStore({
  reducer: {
    TasksSlice,
  },
});

export default store;
