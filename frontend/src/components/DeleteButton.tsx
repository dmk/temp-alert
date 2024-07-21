import React from 'react';
import axios from 'axios';
import { mutate } from 'swr';

import IconButton from '@mui/material/IconButton';
import DeleteIcon from '@mui/icons-material/Delete';
import { getApiUrl } from '@/utils/api';

interface DeleteButtonProps {
  id: string;
}

const DeleteButton: React.FC<DeleteButtonProps> = ({ id }) => {
  const handleDelete = async () => {
    try {
      await axios.delete(getApiUrl(`/alerts/${id}`));
      mutate(getApiUrl('/alerts'));
    } catch (err) {
      console.error(err);
    }
  };

  return (
    <IconButton edge="end" aria-label="delete" className='delete-button' onClick={handleDelete}>
      <DeleteIcon />
    </IconButton>
  );
};

export default DeleteButton;
