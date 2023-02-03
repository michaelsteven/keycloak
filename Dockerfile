FROM keycloak/keycloak:20.0 as builder
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres
WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM keycloak/keycloak:20.0
COPY --from=builder /opt/keycloak/ /opt/keycloak/
#ENV KC_PROXY=edge
ENV KC_HTTP_ENABLED=true
ENV KC_HOSTNAME_STRICT=false
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]