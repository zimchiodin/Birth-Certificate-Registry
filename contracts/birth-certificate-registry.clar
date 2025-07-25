;; Birth Certificate Registry Contract
;; Manages secure birth certificate records on Stacks

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-exists (err u102))
(define-constant err-unauthorized (err u103))

(define-map birth-certificates
  { certificate-id: uint }
  {
    baby-name: (string-ascii 50),
    birth-date: uint,
    birth-location: (string-ascii 100),
    mother-principal: principal,
    midwife-principal: principal,
    weight: uint,
    length: uint,
    issued-at: uint
  }
)

(define-map authorized-midwives principal bool)
(define-data-var next-certificate-id uint u1)

;; Authorize a midwife to issue certificates
(define-public (authorize-midwife (midwife principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (ok (map-set authorized-midwives midwife true))
  )
)

;; Issue a new birth certificate
(define-public (issue-certificate 
  (baby-name (string-ascii 50))
  (birth-date uint)
  (birth-location (string-ascii 100))
  (mother-principal principal)
  (weight uint)
  (length uint))
  (let ((certificate-id (var-get next-certificate-id)))
    (asserts! (default-to false (map-get? authorized-midwives tx-sender)) err-unauthorized)
    (asserts! (is-none (map-get? birth-certificates {certificate-id: certificate-id})) err-already-exists)
    (map-set birth-certificates
      {certificate-id: certificate-id}
      {
        baby-name: baby-name,
        birth-date: birth-date,
        birth-location: birth-location,
        mother-principal: mother-principal,
        midwife-principal: tx-sender,
        weight: weight,
        length: length,
        issued-at: stacks-block-height
      }
    )
    (var-set next-certificate-id (+ certificate-id u1))
    (ok certificate-id)
  )
)

;; Get birth certificate by ID
(define-read-only (get-certificate (certificate-id uint))
  (map-get? birth-certificates {certificate-id: certificate-id})
)

;; Check if midwife is authorized
(define-read-only (is-authorized-midwife (midwife principal))
  (default-to false (map-get? authorized-midwives midwife))
)

;; Get next certificate ID
(define-read-only (get-next-certificate-id)
  (var-get next-certificate-id)
)