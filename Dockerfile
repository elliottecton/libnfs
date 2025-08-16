FROM registry.access.redhat.com/ubi9/ubi

# Install runtime dependencies
RUN microdnf install -y \
    krb5-libs \
    krb5-workstation \
    && microdnf clean all

# Copy your custom libnfs and binary
COPY libnfs.so.16 /usr/local/lib/libnfs.so.16
COPY nfsclient-async /usr/local/bin/nfsclient-async
COPY eelliott.keytab /etc/krb5.keytab

# Update linker cache
RUN ldconfig

# Set environment variable for keytab
ENV KRB5_KTNAME=/etc/krb5.keytab
ENV LD_LIBRARY_PATH=/usr/local/lib

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/nfsclient-async"]
