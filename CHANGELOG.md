# Posh-Teamviewer Release History

## 1.0.1
### 06/10/2016

- AccessToken parameters now only support [SecureString].
- The Access token is now kept as a [SecureString] when loaded into the Session and is not converted to plaintext until needed to contact API.

## 1.0.0
### 06/08/2016

- Initial release
- Commands:
    - Connect-Teamviewer, Initialize-Teamviewer, Update-TeamviewerDevice, Set-TeamviewerAccessToken, Set-TeamviewerDeviceList