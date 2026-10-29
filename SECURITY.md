# Security and privacy checklist

- Keep Docker, the OS, and container images updated.
- Do not expose the Docker socket or Portainer directly to the public internet.
- Do not forward ports 9000, 3001, or database ports from your router.
- Use strong unique admin passwords and enable MFA wherever supported.
- Keep `.env` files out of Git; use `.env.example` only for non-secret defaults.
- Use a separate database, credentials, and Docker network per application.
- Back up app data to a separate physical drive and test restoring it.
- Before remote access, set up HTTPS and an authenticated VPN (e.g. WireGuard/Tailscale) or a carefully reviewed tunnel.
- Only import contact/business data that you are authorized to use; respect privacy, consent, and source-site terms.
