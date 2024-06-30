# Generate SSL Certificates with XAMPP

This script automates the process of generating and installing SSL certificates for XAMPP using OpenSSL.

## Prerequisites

- **XAMPP**: Ensure XAMPP is installed on your system.
- **Administrator Privileges**: The script must be run with administrator privileges to install the generated certificate.

## Usage

1. **Setup Directory:**
   - Create a directory named `crt` inside `xampp/apache/`.
   - Place the following files from this repository inside `xampp/apache/crt/`:
     - `cert-generate.bat`
     - `cert-config.conf`

2. **Generate SSL Certificates:**
   - Open Command Prompt as Administrator.
   - Navigate to the directory containing `cert-generate.bat`.
   - Run the script:
     ```
     cert-generate.bat
     ```
   - Follow the prompts to enter the domain details when prompted.

3. **Install Certificate:**
   - After generating the certificates, the script will provide instructions on installation.
   - Ensure to install the certificate to Trusted Root Certification Authorities store.
     
4. **Update Hosts File:**
   - Open `C:\Windows\System32\drivers\etc\hosts` as Administrator.
   - Add the following line:
     ```
     127.0.0.1 best.site
     ```

5. **Update Apache Configuration:**
   - Open `xampp/apache/conf/extra/httpd-vhosts.conf`.
   - Add the following VirtualHost configuration (replace `best.site` with your actual domain and `best.site-dir` with your actual directory):
     
     ```apache
     ## best.site
     <VirtualHost *:80>
         DocumentRoot "C:/xampp/htdocs/best.site-dir"
         ServerName best.site
         ServerAlias *.best.site
     </VirtualHost>

     <VirtualHost *:443>
         DocumentRoot "C:/xampp/htdocs/best.site-dir"
         ServerName best.site
         ServerAlias *.best.site
         SSLEngine on
         SSLCertificateFile "C:/xampp/apache/crt/best.site/server.crt"
         SSLCertificateKeyFile "C:/xampp/apache/crt/best.site/server.key"
     </VirtualHost>
     ```

6. **Restart Apache:**
   - Restart Apache in XAMPP to apply the configuration changes.
     
## Notes

- **Administrator Rights**: Running `cert-generate.bat` requires administrator rights for certificate installation.
- **Directory Structure**: Ensure the `crt` directory is correctly set up inside `xampp/apache/` before running the script.
