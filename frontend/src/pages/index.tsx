import Container from '@mui/material/Container';

import AlertList from '@/components/AlertList';
import Navbar from '@/components/Navbar';

export default function Home() {
  return (
    <>
      <Navbar />
      <Container sx={{mt: 3}}>
        <AlertList />
      </Container>
    </>
  );
}
