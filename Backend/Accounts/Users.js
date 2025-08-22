const express = require('express');
const router = express.Router();

router.get('/users', async (req, res) => {
  const users = await prisma.users.findMany();
  res.json(users);
});

router.post('/users', async (req, res) => {
  const { 
    email,
    phone,
    password,
    userType 
  } = req.body;
  const dateToday = new Date();
  const formattedDate = dateToday.toLocaleString('en-US', {
    month: 'long',
    day: 'numeric',
    year: 'numeric',
    hour: 'numeric',
    minute: '2-digit',
    hour12: true,
  });

  const existingEmail = await prisma.users.findUnique({
    where: { email }
  });
  
  if (existingEmail) {
    return res.status(400).json({ error: 'This email is already registered.' });
  }

  const existingPhoneNumber = await prisma.users.findUnique({
    where: { phone_number: phone }
  });

  if (existingPhoneNumber) {
    return res.status(400).json({ error: 'This phone number is already registered.' });
  }

  const user = await prisma.users.create({
    data: { 
      email: email, 
      password_hash: password, 
      phone_number: phone, 
      user_type: userType,
      created_at: formattedDate,
    }
  });

  res.status(201).json({ message: 'Registration successful', user });
});

router.get('/users/pwd', async (req, res) => {
  const pwds = await prisma.pwd_Profile.findMany();
  res.json(pwds);
});

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

module.exports = router;