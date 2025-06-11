# Changelog Tenure

## Table of Contents

- **[r1.2](#r12)**
- [r1.1](#r11)

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

# r1.2

## Release Notes

This release contains the definition and documentation of
* kyc-tenure v0.1.0

The API definition(s) are based on
* Commonalities v0.5.0
* Identity and Consent Management v0.3.0

## kyc-tenure v0.1.0

**kyc-tenure v0.1.0 is the first public release version of the Tenure API.**

- kyc-tenure v0.1.0 API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/Tenure/r1.2/code/API_definitions/kyc-tenure.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/Tenure/r1.2/code/API_definitions/kyc-tenure.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/Tenure/blob/r1.2/code/API_definitions/kyc-tenure.yaml)

### Added
* Initial API proposal by @eric-murray in https://github.com/camaraproject/Tenure/pull/11

### Changed
* Request body should be required by @eric-murray in https://github.com/camaraproject/Tenure/pull/15
* Change tenure date format from date-time to date by @eric-murray in https://github.com/camaraproject/Tenure/pull/17
* Update error response schema to align with Commonalities by @eric-murray in https://github.com/camaraproject/Tenure/pull/16
* Update ICM authorisation and authentication wording kyc-tenure.yaml by @eric-murray in https://github.com/camaraproject/Tenure/pull/24
* Remove non mandatory errors following new commonalities by @GillesInnov35 in https://github.com/camaraproject/Tenure/pull/28

## New Contributors
* @eric-murray made their first contribution in https://github.com/camaraproject/Tenure/pull/11

**Full Changelog**: https://github.com/camaraproject/Tenure/commits/r1.2

# r1.1

## Release Notes

This release contains the definition and documentation of
* kyc-tenure v0.1.0-rc.1

The API definition(s) are based on
* Commonalities v0.5.0-alpha.1
* Identity and Consent Management v0.3.0-alpha.1

## kyc-tenure v0.1.0-rc.1

**kyc-tenure v0.1.0-rc.1 is the first release-candidate version for v0.1.0 of the Tenure API.**

- kyc-tenure v0.1.0-rc.1 API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/Tenure/r1.1/code/API_definitions/kyc-tenure.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/Tenure/r1.1/code/API_definitions/kyc-tenure.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/Tenure/blob/r1.1/code/API_definitions/kyc-tenure.yaml)

**Main changes**

* Initial contribution of the API kyc-tenure

### Added

* Initial API proposal by @eric-murray in https://github.com/camaraproject/Tenure/pull/11
* Request body should be required by @eric-murray in https://github.com/camaraproject/Tenure/pull/15
* Change tenure date format from date-time to date by @eric-murray in https://github.com/camaraproject/Tenure/pull/17
* Update error response schema to align with Commonalities by @eric-murray in https://github.com/camaraproject/Tenure/pull/16

## New Contributors
* @eric-murray made their first contribution in https://github.com/camaraproject/Tenure/pull/6

**Full Changelog**: https://github.com/camaraproject/Tenure/commits/r1.1
