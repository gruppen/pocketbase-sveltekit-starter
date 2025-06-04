# Traefik Setup Guide

This project uses Traefik as a reverse proxy for better development and production workflows.

## Current Status ✅

- ✅ **PocketBase service** (pbsk.localhost) - Working correctly 
- ✅ **SvelteKit dev server** (dev.pbsk.localhost) - Working correctly
- ✅ **Traefik dashboard** - Accessible via http://localhost:8080 (credentials: admin/admin)
- ⚠️ **traefik.localhost** - Dashboard only accessible via localhost:8080 for now

**Important**: After making changes to SvelteKit, rebuild for production route:
```bash
docker exec pbsk-sk-1 npm run build
```

## Quick Start

### Windows (PowerShell)
```powershell
.\start-dev.ps1
```

### Manual Setup
1. **Create the Traefik network:**
   ```bash
   docker network create traefik_default
   ```

2. **Start Traefik:**
   ```bash
   docker-compose -f docker-compose.traefik.yml up -d
   ```

3. **Start your application:**
   ```bash
   docker-compose up -d
   ```

## Access Your Services

- **Main Application**: http://pbsk.localhost
- **Development Server**: http://dev.pbsk.localhost  
- **Traefik Dashboard**: http://traefik.localhost
- **Traefik API**: http://localhost:8080

## Hosts File Setup (if needed)

Add these entries to your hosts file:
```
127.0.0.1 pbsk.localhost
127.0.0.1 dev.pbsk.localhost
127.0.0.1 traefik.localhost
```

**Windows hosts file location**: `C:\Windows\System32\drivers\etc\hosts`

## Architecture

```
Internet/Browser
        ↓
    Traefik (Port 80/443)
        ↓
   ┌────────────────┐
   │                │
   ▼                ▼
PocketBase      SvelteKit
 (Port 8090)    (Port 5173)
```

## Configuration Files

- `docker-compose.traefik.yml` - Traefik service configuration
- `docker-compose.override.yml` - Development overrides with Traefik labels
- `.env` - Environment variables including `HTTP_HOSTNAME`

## Production Notes

- Change `--api.insecure=true` to `false` in production
- Update the email in certificate resolver
- Generate proper BasicAuth password for Traefik dashboard
- Consider using a proper domain instead of `.localhost`

## Troubleshooting

1. **Can't access services**: Check if Docker containers are running
   ```bash
   docker-compose ps
   ```

2. **Network issues**: Ensure the traefik_default network exists
   ```bash
   docker network ls
   ```

3. **DNS issues**: Add entries to your hosts file or use a local DNS server

4. **View logs**: 
   ```bash
   docker-compose logs -f traefik
   docker-compose logs -f pb
   docker-compose logs -f sk
   ```
