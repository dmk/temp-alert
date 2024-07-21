import React from 'react';
import useSWR from 'swr';
import axios from 'axios';

import Container from '@mui/material/Container';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';
import Typography from '@mui/material/Typography';
import { Alert } from '@/types/alert';
import DeleteButton from './DeleteButton';
import { getApiUrl } from '@/utils/api';

const fetcher = async (url: string): Promise<Alert[]> => {
  const response = await axios.get<Alert[]>(url);
  return response.data;
};

const AlertList: React.FC = () => {
  const { data, error } = useSWR<Alert[]>(getApiUrl('/alerts'), fetcher);

  if (error) return <Typography color="error">Failed to load</Typography>;
  if (!data) return <Typography>Loading...</Typography>;

  return (
    <Container>
      <Typography variant="h5">Planned Alerts</Typography>
      {data.length > 0 ? (
        <List>
          {data.map((alert) => (
            <ListItem
              key={alert.id}
              secondaryAction={
                <DeleteButton id={alert.id} />
              }
            >
              <ListItemText
                primary={alert.message}
                secondary={`Instance: ${alert.instance} | Notification At: ${new Date(alert.notify_at).toLocaleString()}`}
              />
            </ListItem>
          ))}
        </List>
      ) : (
        <Typography>No alerts planned yet.</Typography>
      )}
    </Container>
  );
};

export default AlertList;
