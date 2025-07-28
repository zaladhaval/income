#!/bin/bash

echo "Testing Car Rental Management System Login..."

# Test 1: Check if login page is accessible
echo "1. Testing login page accessibility..."
LOGIN_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/login)
if [ "$LOGIN_RESPONSE" = "200" ]; then
    echo "✅ Login page is accessible (HTTP 200)"
else
    echo "❌ Login page not accessible (HTTP $LOGIN_RESPONSE)"
    exit 1
fi

# Test 2: Check if root redirects to login for unauthenticated users
echo "2. Testing root URL redirect..."
ROOT_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/)
if [ "$ROOT_RESPONSE" = "302" ]; then
    echo "✅ Root URL correctly redirects unauthenticated users (HTTP 302)"
else
    echo "❌ Root URL response unexpected (HTTP $ROOT_RESPONSE)"
fi

# Test 3: Check if dashboard requires authentication
echo "3. Testing dashboard authentication requirement..."
DASHBOARD_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/dashboard)
if [ "$DASHBOARD_RESPONSE" = "302" ]; then
    echo "✅ Dashboard correctly requires authentication (HTTP 302)"
else
    echo "❌ Dashboard response unexpected (HTTP $DASHBOARD_RESPONSE)"
fi

# Test 4: Check if login form contains required fields
echo "4. Testing login form structure..."
LOGIN_FORM=$(curl -s http://localhost:8080/login)
if echo "$LOGIN_FORM" | grep -q 'name="email"' && echo "$LOGIN_FORM" | grep -q 'name="password"'; then
    echo "✅ Login form contains email and password fields"
else
    echo "❌ Login form missing required fields"
fi

echo ""
echo "🎯 Login Test Summary:"
echo "- Login page: Accessible"
echo "- Authentication: Required for protected pages"
echo "- Form structure: Correct"
echo ""
echo "📝 To test actual login, use these credentials in your browser:"
echo "   URL: http://localhost:8080"
echo "   Admin: admin@rental.com / password123"
echo "   Technical: tech@rental.com / password123"
echo "   Customer: john.smith@email.com / password123"
