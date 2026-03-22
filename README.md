# Distroless musl libc container base

Bare-bones distroless container image base that contains musl libc, tzdata, and mozilla CA certificates.

## Building

| Arg | Description |
|---|---|
| `MUSL_VERSION` | Version of musl libc to use
| `TZDB_VERSION` | Version of TZ to use

Build container using build-args from versions.yaml:

```bash
docker build -t \
  distroless-gotify:$(yq -r .musl versions.yaml) \
  $(yq -r 'to_entries | .[] | "--build-arg \(.key | ascii_upcase)_VERSION=\(.value)"' versions.yaml) -f Containerfile .
```

## License

Repository contents (e.g., `Containerfile`, build scripts, and configuration) are licensed under the **MIT License**.

Software included in built container images (such as **musl**, **tzdata**, and **Mozilla CA Certificates**) are provided under their respective upstream licenses and is not covered by the MIT license for this repository.

## Acknowledgements

This project depends on a number of upstream components and data sources:

- **musl** – Lightweight C standard library implementation for Linux providing the standard C runtime and POSIX interfaces with a focus on simplicity, correctness, and static linking.  
  https://musl.libc.org/

- **tzdata** – The IANA Time Zone Database, which provides the canonical global timezone definitions used for correct time handling.  
  https://www.iana.org/time-zones

- **Mozilla CA Certificates** – The curated set of trusted root Certificate Authorities maintained by Mozilla and used by many systems for TLS verification.  
  https://wiki.mozilla.org/CA
