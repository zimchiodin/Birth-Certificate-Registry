# BirthCert - Decentralized Birth Certificate Registry

A secure, blockchain-based birth certificate registry built on Stacks that enables authorized midwives to issue tamper-proof birth certificates.

## Features

- **Secure Certificate Issuance**: Only authorized midwives can issue birth certificates
- **Immutable Records**: Birth certificates are permanently stored on the blockchain
- **Easy Verification**: Anyone can verify certificate authenticity using the certificate ID
- **Comprehensive Data**: Records baby details, birth information, and issuing midwife

## Contract Functions

### Public Functions
- `authorize-midwife(midwife)` - Authorize a midwife to issue certificates (owner only)
- `issue-certificate(...)` - Issue a new birth certificate (authorized midwives only)

### Read-Only Functions
- `get-certificate(certificate-id)` - Retrieve certificate details
- `is-authorized-midwife(midwife)` - Check midwife authorization status
- `get-next-certificate-id()` - Get the next available certificate ID

## Usage

1. Deploy the contract to Stacks testnet/mainnet
2. Authorize midwives using `authorize-midwife`
3. Authorized midwives can issue certificates using `issue-certificate`
4. Anyone can verify certificates using `get-certificate`

## Security Features

- Owner-only midwife authorization
- Certificate immutability
- Principal-based authentication
- Comprehensive error handling

## License

MIT License