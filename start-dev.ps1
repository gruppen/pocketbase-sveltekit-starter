# Traefik + PocketBase SvelteKit Starter Script
# This script sets up and starts your development environment with Traefik

Write-Host "🚀 Starting Traefik + PocketBase SvelteKit Development Environment" -ForegroundColor Green

# Step 1: Create the external network if it doesn't exist
Write-Host "📡 Creating traefik network..." -ForegroundColor Yellow
try {
    docker network create traefik_default 2>$null
    Write-Host "✅ Network 'traefik_default' created successfully" -ForegroundColor Green
} catch {
    Write-Host "ℹ️  Network 'traefik_default' already exists" -ForegroundColor Cyan
}

# Step 2: Start Traefik (if not already running)
Write-Host "🔄 Starting Traefik..." -ForegroundColor Yellow
docker-compose -f docker-compose.traefik.yml up -d

# Step 3: Start your application
Write-Host "🔄 Starting PocketBase + SvelteKit..." -ForegroundColor Yellow
docker-compose up -d

Write-Host ""
Write-Host "🎉 Setup Complete!" -ForegroundColor Green
Write-Host "📋 Available Services:" -ForegroundColor Cyan
Write-Host "   🌐 Main App: http://pbsk.localhost" -ForegroundColor White
Write-Host "   🔧 Dev Server: http://dev.pbsk.localhost" -ForegroundColor White  
Write-Host "   📊 Traefik Dashboard: http://traefik.localhost" -ForegroundColor White
Write-Host "   📊 Traefik API: http://localhost:8080" -ForegroundColor White
Write-Host ""
Write-Host "💡 Add these to your hosts file if needed:" -ForegroundColor Yellow
Write-Host "   127.0.0.1 pbsk.localhost" -ForegroundColor Gray
Write-Host "   127.0.0.1 dev.pbsk.localhost" -ForegroundColor Gray
Write-Host "   127.0.0.1 traefik.localhost" -ForegroundColor Gray
Write-Host ""
Write-Host "🔍 To view logs: docker-compose logs -f" -ForegroundColor Cyan
Write-Host "🛑 To stop: docker-compose down" -ForegroundColor Cyan
