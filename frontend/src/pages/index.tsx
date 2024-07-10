import useSWR, { mutate } from 'swr';
import axios from 'axios';
import { useState } from 'react';

const fetcher = (url: string) => fetch(url).then((res) => res.json());

export default function Home() {
  const { data, error } = useSWR('/api/v1/alerts', fetcher);
  const [loading, setLoading] = useState(false);

  const createAlert = async () => {
    setLoading(true);
    try {
      const response = await axios.post('/api/v1/alerts', {
        instance: 'test_instance',
        alert_instance: 'test_alert_instance',
        message: 'This is a test alert',
        notify_at: new Date().toISOString(),
      });
      // Revalidate the SWR cache
      mutate('/api/v1/alerts');
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  if (error) return <div>Failed to load</div>;
  if (!data) return <div>Loading...</div>;

  return (
    <>
      <h1>TempAlert</h1>
      <button onClick={createAlert} disabled={loading}>
        {loading ? 'Creating...' : 'Create Alert'}
      </button>
      <pre>{JSON.stringify(data, null, 2)}</pre>
    </>
  );
}
