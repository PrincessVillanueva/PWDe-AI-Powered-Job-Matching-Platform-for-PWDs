const express = require('express');
const cors = require('cors');
const { PrismaClient } = require('@prisma/client');
const { withAccelerate } = require('@prisma/extension-accelerate');

const prisma = new PrismaClient().$extends(withAccelerate());
const app = express();

app.use(cors());
app.use(express.json());

app.use('/accounts', usersRouter);

/*
app.put('/users/:id', async (req, res) => {
  const { id } = req.params;
  const { email, password_hash, phone_number, user_type, account_status, is_verified } = req.body;

  const userExists = await prisma.users.findUnique({
    where: { user_Id: Number(id) }
  });

  if (!userExists) {
    return res.status(404).json({ error: `User with ID ${id} not found` });
  } else {
    const user = await prisma.users.update({
    where: { user_Id: Number(id) },
    data: { 
      email, 
      password_hash, 
      phone_number, 
      user_type,
      account_status,
      is_verified 
      }
    });
    res.json(user);
  }
});

app.delete('/users/:id', async (req, res) => {
  const { id } = req.params;

  const userExists = await prisma.users.findUnique({
    where: { user_Id: Number(id) }
  });

  if (!userExists) {
    return res.status(404).json({ error: `User with ID ${id} not found` });
  }

  await prisma.users.delete({
    where: { user_Id: Number(id) }
  });
  res.json({ message: `User ${id} deleted` });
});
*/

app.listen(4000, () => console.log(`Server running on http://localhost:4000`));