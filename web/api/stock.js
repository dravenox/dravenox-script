let stockData = {
  egg_stock: {},
  gear_stock: {}
};

export default async function handler(req, res) {
  if (req.method === 'POST') {
    try {
      const body = req.body;
      if (!body.egg_stock && !body.gear_stock) {
        return res.status(400).json({ error: 'Missing stock data' });
      }

  
      if (body.egg_stock) stockData.egg_stock = body.egg_stock;
      if (body.gear_stock) stockData.gear_stock = body.gear_stock;

      return res.status(200).json({ success: true, message: 'Stock updated', data: stockData });
    } catch (err) {
      return res.status(500).json({ error: 'Failed to parse body' });
    }
  }

  if (req.method === 'GET') {
    return res.status(200).json(stockData);
  }

  return res.status(405).json({ error: 'Method not allowed' });
}
