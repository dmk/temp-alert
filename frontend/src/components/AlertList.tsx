import React from 'react';
import useSWR from 'swr';
import axios from 'axios';

import Container from '@mui/material/Container';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';
import Typography from '@mui/material/Typography';
import { styled } from '@mui/material/styles';
import { Alert } from '@/types/alert';
import DeleteButton from './DeleteButton';

const fetcher = async (url: string): Promise<Alert[]> => {
  const response = await axios.get<Alert[]>(url);
  return response.data;
};

// const CustomListItem = styled(ListItem)(({ theme }) => ({
//   transition: 'background-color 0.1s ease-in-out',
//   '&:hover': {
//     backgroundColor: theme.palette.action.hover,
//     '& .delete-button': {
//       display: 'inline-flex',
//     },
//   },
//   '& .delete-button': {
//     display: 'none',
//   },
// }));

const AlertList: React.FC = () => {
  const { data, error } = useSWR<Alert[]>('/api/v1/alerts', fetcher);

  if (error) return <Typography color="error">Failed to load</Typography>;
  if (!data) return <Typography>Loading...</Typography>;

  return (
    <Container sx={{maxWidth: '512px'}}>
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
