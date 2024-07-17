import Container from '@mui/material/Container';

import AlertList from '@/components/AlertList';
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';

export default function Home() {
  return (
    <div className="main-container">
      <Navbar />
      <Container sx={{
        mt: 3,
        flex: 1,
      }}>
        <AlertList />
      </Container>
      <Footer />
    </div>
  );
}
