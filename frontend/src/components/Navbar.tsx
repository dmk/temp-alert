import React, { useState } from 'react';

import AppBar from '@mui/material/AppBar';
import Button from '@mui/material/Button';
import Dialog from '@mui/material/Dialog';
import DialogContent from '@mui/material/DialogContent';
import DialogTitle from '@mui/material/DialogTitle';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';

import CreateAlertForm from './CreateAlertForm';

const Navbar: React.FC = () => {
  const [open, setOpen] = useState<boolean>(false);

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  return (
    <>
      <AppBar position="static">
        <Container>
          <Toolbar>
            <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
              TempAlert
            </Typography>
            <Button color="inherit" onClick={handleClickOpen}>
              Create Alert
            </Button>
          </Toolbar>
        </Container>
      </AppBar>
      <Dialog open={open} onClose={handleClose}>
        <DialogTitle>Create Alert</DialogTitle>
        <DialogContent>
          <CreateAlertForm />
        </DialogContent>
      </Dialog>
    </>
  );
};

export default Navbar;