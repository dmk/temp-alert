import React, { useState } from 'react';

import axios from 'axios';
import { mutate } from 'swr';

import Stack from '@mui/material/Stack';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';

import { Alert } from '@/types/alert';

const CreateAlertForm: React.FC = () => {
  const [instance, setInstance] = useState<string>('');
  const [message, setMessage] = useState<string>('');
  const [notifyAt, setNotifyAt] = useState<string>('');
  const [loading, setLoading] = useState<boolean>(false);

  const createAlert = async () => {
    setLoading(true);
    try {
      await axios.post<Alert>('/api/v1/alerts', {
        instance,
        message,
        notify_at: new Date(notifyAt).toISOString(),
      });
      mutate('/api/v1/alerts');
      setInstance('');
      setMessage('');
      setNotifyAt('');
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Stack
      component="form"
      spacing={2}
      sx={{ mx: 1, mb: 1, mt: .7, minWidth: 512 }}
    >
      <TextField
        label="Message"
        value={message}
        variant='outlined'
        onChange={(e) => setMessage(e.target.value)}
        fullWidth
        InputLabelProps={{
          shrink: true,
        }}
      />
      <TextField
        label="Instance"
        value={instance}
        variant='outlined'
        onChange={(e) => setInstance(e.target.value)}
        fullWidth
        InputLabelProps={{
          shrink: true,
        }}
      />
      <TextField
        label="Notify At"
        type="datetime-local"
        value={notifyAt}
        variant='outlined'
        onChange={(e) => setNotifyAt(e.target.value)}
        fullWidth
        InputLabelProps={{
          shrink: true,
        }}
      />
      <Button
        variant="contained"
        color="primary"
        onClick={createAlert}
        disabled={loading}
        fullWidth
      >
        {loading ? 'Creating...' : 'Create Alert'}
      </Button>
    </Stack>
  );
};

export default CreateAlertForm;
