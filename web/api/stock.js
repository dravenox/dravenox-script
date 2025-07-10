let cachedData = null;

export default async function handler(req, res) {
  const AUTH_TOKEN = 'dravenox-secret-token'; // GANTI dengan token milikmu sendiri

  if (req.method === 'POST') {
    const token = req.headers.authorization?.split(' ')[1];

    if (!token || token !== AUTH_TOKEN) {
      return res.status(401).json({ error: 'Unauthorized' });
    }

    try {
      const data = req.body;

      // Validasi kasar, minimal harus ada 1 kategori
      if (!data || typeof data !== 'object') {
        return res.status(400).json({ error: 'Invalid JSON' });
      }

      cachedData = {
        ...data,
        updated_at: new Date().toISOString(),
      };

      return res.status(200).json({ message: 'Stock updated' });
    } catch (err) {
      return res.status(500).json({ error: 'Internal Server Error' });
    }
  }

  if (req.method === 'GET') {
    if (!cachedData) {
      return res.status(404).json({ error: 'No stock data yet' });
    }

    return res.status(200).json(cachedData);
  }

  return res.status(405).json({ error: 'Method Not Allowed' });
}
