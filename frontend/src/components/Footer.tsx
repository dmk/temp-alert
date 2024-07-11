import { Typography, Box } from '@mui/material';

const Footer = () => {
  return (
    <Box component="footer" sx={{ p: 2, textAlign: 'center' }}>
      <Typography variant="body2" color="textSecondary">
        Version: {process.env.APP_VERSION}
      </Typography>
    </Box>
  );
};

export default Footer;
