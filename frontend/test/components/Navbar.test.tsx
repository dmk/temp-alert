import { render, screen, fireEvent } from '@testing-library/react';
import Navbar from '@/components/Navbar';

test('renders the Navbar with the correct title', () => {
  render(<Navbar />);
  expect(screen.getByText('TempAlert')).toBeTruthy();
});
