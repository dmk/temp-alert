import React from 'react';
import axios from 'axios';
import { mutate } from 'swr';

import IconButton from '@mui/material/IconButton';
import DeleteIcon from '@mui/icons-material/Delete';

interface DeleteButtonProps {
  id: string;
}

const DeleteButton: React.FC<DeleteButtonProps> = ({ id }) => {
  const handleDelete = async () => {
    try {
      await axios.delete(`/api/v1/alerts/${id}`);
      mutate('/api/v1/alerts');
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
