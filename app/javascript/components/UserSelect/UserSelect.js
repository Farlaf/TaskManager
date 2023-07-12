import React, { useState } from 'react';
import PropTypes from 'prop-types';

import AsyncSelect from 'react-select/async';
import { FormControl, FormHelperText, InputLabel } from '@material-ui/core';

import UsersRepository from 'repositories/UsersRepository';

import useStyles from './useStyles';

import UserPresenter from '../../presenters/UserPresenter';

function UserSelect({ error, label, isClearable, isDisabled, isRequired, onChange, value, helperText, userType }) {
  const [isFocused, setFocus] = useState(false);
  const styles = useStyles();
  const handleLoadOptions = (inputValue) =>
    UsersRepository.index({ q: { firstNameOrLastNameCont: inputValue, type_eq: userType } }).then(
      ({ data }) => data.items,
    );

  return (
    <FormControl margin="dense" disabled={isDisabled} focused={isFocused} error={error} required={isRequired}>
      <InputLabel shrink>{label}</InputLabel>
      <div className={styles.select}>
        <AsyncSelect
          cacheOptions
          loadOptions={handleLoadOptions}
          defaultOptions
          getOptionLabel={(user) => `${UserPresenter.fullName(user)}`}
          getOptionValue={(user) => UserPresenter.id(user)}
          isDisabled={isDisabled}
          isClearable={isClearable}
          defaultValue={value}
          onChange={onChange}
          onFocus={() => setFocus(true)}
          onBlur={() => setFocus(false)}
          menuPortalTarget={document.body}
          styles={{ menuPortal: (base) => ({ ...base, zIndex: 9999 }) }}
        />
      </div>
      {helperText && <FormHelperText>{helperText}</FormHelperText>}
    </FormControl>
  );
}

UserSelect.defaultProps = {
  isClearable: true,
  isDisabled: false,
  isRequired: false,
  value: UserPresenter.shape(),
  helperText: undefined,
};

UserSelect.propTypes = {
  error: PropTypes.bool.isRequired,
  label: PropTypes.string.isRequired,
  isClearable: PropTypes.bool,
  isDisabled: PropTypes.bool,
  isRequired: PropTypes.bool,
  onChange: PropTypes.func.isRequired,
  value: UserPresenter.shape(),
  userType: UserPresenter.type.isRequired,
  helperText: PropTypes.oneOfType(PropTypes.string, PropTypes.arrayOf(PropTypes.string)),
};

export default UserSelect;
