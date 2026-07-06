[![Current Version](https://raw.githubusercontent.com/simons-containers/distroless-musl/badges/.badges/main/release.svg)](https://github.com/simons-containers/distroless-musl/pkgs/container/distroless-musl) [![Tags](https://raw.githubusercontent.com/simons-containers/distroless-musl/badges/.badges/main/tags.svg)](https://github.com/simons-containers/distroless-musl/pkgs/container/distroless-musl) <br> ![Current Size](https://raw.githubusercontent.com/simons-containers/distroless-musl/badges/.badges/main/size.svg) ![Wasted Size](https://raw.githubusercontent.com/simons-containers/distroless-musl/badges/.badges/main/wasted.svg) ![Efficiency](https://raw.githubusercontent.com/simons-containers/distroless-musl/badges/.badges/main/efficiency.svg) <br> ![Critical](https://raw.githubusercontent.com/simons-containers/distroless-musl/badges/.badges/main/critical.svg) ![High](https://raw.githubusercontent.com/simons-containers/distroless-musl/badges/.badges/main/high.svg) ![Medium](https://raw.githubusercontent.com/simons-containers/distroless-musl/badges/.badges/main/medium.svg) ![Low](https://raw.githubusercontent.com/simons-containers/distroless-musl/badges/.badges/main/low.svg) <br> [![Publish Workflow](https://img.shields.io/github/actions/workflow/status/simons-containers/distroless-musl/deploy.yaml?label=Publish%20Workflow&logo=github)](https://github.com/simons-containers/distroless-musl/actions/workflows/deploy.yaml) [![Update Workflow](https://img.shields.io/github/actions/workflow/status/simons-containers/distroless-musl/update-versions.yaml?label=Update%20Workflow&logo=github)](https://github.com/simons-containers/distroless-musl/actions/workflows/update-versions.yaml)

# Distroless musl libc container base

Bare-bones distroless container image base that contains musl libc, tzdata, and mozilla CA certificates.

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
