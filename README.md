# Duolingo Clone

A full-stack Duolingo Clone built with **Next.js**, containerized using **Docker**, and deployed to **AWS EC2**. This project showcases real-world DevOps skills — from local development and Docker image management to remote deployment on cloud infrastructure.

## Features

- **Frontend**: Next.js, TypeScript, TailwindCSS, ShadCN UI
- **Backend**: Drizzle, Neon (PostgreSQL)
- **State Management**: Zustand
- **HTTP Requests**: Axios
- **Admin Dashboard**: `react-admin`
- **Payments**: Stripe integration
- **Authentication**: Google SSO
- **Containerization**: Docker  
- **Deployment**: AWS EC2

## 🎯 Project Goals

- Replicate the Duolingo UI
- Integrate user authentication using Parse
- Containerize the application using Docker
- Deploy and run the app in a cloud environment (EC2)

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Ursulaonyi/Duolingo-Clone.git
   cd Duolingo-Clone
   
2. **Install Dependencies**
   ```bash
   npm install
   
3. **Set up environment variables** <br/>
   Create a .env file in the root directory and add the necessary environment variables.
   *Namely*
   ```bash
   NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY 
   CLERK_SECRET_KEY 
   DATABASE_URL
   STRIPE_API_KEY
   NEXT_PUBLIC_APP_URL
   STRIPE_WEBHOOK_SECRET
   ```
   
4. **Build and Run Locally**

```bash
npm run dev
```
---

## 🐳 Docker Setup

### 2. Build Docker Image

```Dockerfile
# Dockerfile (Multistage Build)

FROM node:18-alpine3.21 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm cache clean --force && npm config set registry https://registry.npmjs.org/
RUN npm install
COPY . .
RUN npm run build

FROM node:18-alpine3.21
WORKDIR /app
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/next.config.mjs ./
COPY --from=builder /app/.env ./
RUN npm install --omit=dev
EXPOSE 3000
CMD ["npm", "start"]
```

### 3. Build and Run Locally

```bash
docker build -t duolingo-clone .
docker run -d -p 3000:3000 --name duolingo-app duolingo-clone
```

Access the app at: [http://localhost:3000](http://localhost:3000)

---

## 📦 Push to Docker Hub

```bash
docker tag duolingo-clone dockerhubusername/duolingo-clone
docker push dockerhubusername/duolingo-clone
```

---

## ☁️ Deployment on AWS EC2

1. SSH into your EC2 instance  
2. Install Docker:

```bash
sudo apt update
sudo apt install docker.io -y
```

3. Add your user to the Docker group:

```bash
sudo usermod -aG docker $USER
# Log out and back in
```

4. Deploy the app:

```bash
docker login
docker pull dockerhubusername/duolingo-clone
docker run -d -p 3000:3000 --name duolingo-app dockerhubusername/duolingo-clone
```

Visit: `http://<EC2_PUBLIC_IP>:3000`

---

## ✅ Status

- [x] UI Replication  
- [x] Auth Integration  
- [x] Dockerized  
- [x] Deployed to EC2  

---

## License
This project is licensed under the MIT License.

```Note: I chose the MIT License because it is a permissive open source license that allows others to freely use, modify, and distribute the code with minimal restrictions.```

## Usage
- Register or log in using Google SSO.
- Explore language courses and track your progress.
- Admins can manage content through the admin dashboard.
- Upgrade to premium for additional features using Stripe.
  
## Contributing <br />
Contributions are welcome! Please follow these steps: <br />

1. Fork the repository.
2. Create a new branch.
3. Make your changes and commit them.
4. Push to your branch.
5. Open a pull request.


## 🙋‍♀️ Author

**Ursula Onyinye**  
[GitHub](https://github.com/ursulaonyi) | [Docker Hub](https://hub.docker.com/u/ursulaonyi)