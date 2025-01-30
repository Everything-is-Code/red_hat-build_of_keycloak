--
-- PostgreSQL database dump
--

-- Dumped from database version 10.23
-- Dumped by pg_dump version 10.23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: oskeycloak0jbosststxtable; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.oskeycloak0jbosststxtable (
    statetype integer NOT NULL,
    hidden integer NOT NULL,
    typename character varying(255) NOT NULL,
    uidstring character varying(255) NOT NULL,
    objectstate bytea
);


ALTER TABLE public.oskeycloak0jbosststxtable OWNER TO keycloak;

--
-- Name: oskeycloak1jbosststxtable; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.oskeycloak1jbosststxtable (
    statetype integer NOT NULL,
    hidden integer NOT NULL,
    typename character varying(255) NOT NULL,
    uidstring character varying(255) NOT NULL,
    objectstate bytea
);


ALTER TABLE public.oskeycloak1jbosststxtable OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
82fc3f01-133d-4795-9df1-12276e3d6f71	\N	auth-cookie	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	2176bd5a-7258-4f22-91c7-8e082f45f4ce	2	10	f	\N	\N
cdd70ea2-deed-481b-825d-505008e4e338	\N	auth-spnego	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	2176bd5a-7258-4f22-91c7-8e082f45f4ce	3	20	f	\N	\N
e4c6c2a7-3b05-4470-bede-f26ce2834f50	\N	identity-provider-redirector	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	2176bd5a-7258-4f22-91c7-8e082f45f4ce	2	25	f	\N	\N
5347bb48-f50c-429f-bcba-69f05a4ce223	\N	\N	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	2176bd5a-7258-4f22-91c7-8e082f45f4ce	2	30	t	81b8dd1b-f8e0-4834-bd91-ada711a2ae9f	\N
bc215b40-5bbf-4c7b-9c7b-3470299ccf8b	\N	auth-username-password-form	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	81b8dd1b-f8e0-4834-bd91-ada711a2ae9f	0	10	f	\N	\N
ee4ed06f-3d8c-4dc1-b45d-af092364d9ff	\N	\N	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	81b8dd1b-f8e0-4834-bd91-ada711a2ae9f	1	20	t	8d1971fa-2e45-43b2-b861-8a985e5649b3	\N
d9163a12-60c6-4a42-a445-cac66e026d76	\N	conditional-user-configured	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	8d1971fa-2e45-43b2-b861-8a985e5649b3	0	10	f	\N	\N
5df7d449-be2c-4f4a-ae0a-1ca841d60fb7	\N	auth-otp-form	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	8d1971fa-2e45-43b2-b861-8a985e5649b3	0	20	f	\N	\N
68429926-343d-4eb4-8feb-9fe3092fe07e	\N	direct-grant-validate-username	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	3df2e182-a333-4a71-92db-c7a5dd12b45e	0	10	f	\N	\N
3319828b-119c-45c2-94a9-c0b31b18580d	\N	direct-grant-validate-password	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	3df2e182-a333-4a71-92db-c7a5dd12b45e	0	20	f	\N	\N
bfd03a63-35cc-47cb-bd46-ae1d02269136	\N	\N	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	3df2e182-a333-4a71-92db-c7a5dd12b45e	1	30	t	712873ea-ce88-4795-82fb-ad63eaa27183	\N
16305e8c-da9d-4bcc-9f30-0a3073e85054	\N	conditional-user-configured	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	712873ea-ce88-4795-82fb-ad63eaa27183	0	10	f	\N	\N
4d1ed713-3919-43a8-b0d7-af169d4ef6ed	\N	direct-grant-validate-otp	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	712873ea-ce88-4795-82fb-ad63eaa27183	0	20	f	\N	\N
88eee54c-d962-4580-8604-25b817a76716	\N	registration-page-form	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	a40418aa-f3ac-48a9-a074-b4857d96284f	0	10	t	d7da4c67-d822-4f53-a05a-204d841018c5	\N
cbcaf6cb-c135-4aaf-9130-d64ffbf2493b	\N	registration-user-creation	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	d7da4c67-d822-4f53-a05a-204d841018c5	0	20	f	\N	\N
08ac1781-00f2-4f11-a3ea-e412c0424ba9	\N	registration-profile-action	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	d7da4c67-d822-4f53-a05a-204d841018c5	0	40	f	\N	\N
c2948087-ac2d-4ad2-8b25-3765570627f7	\N	registration-password-action	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	d7da4c67-d822-4f53-a05a-204d841018c5	0	50	f	\N	\N
1593023b-a30f-4eb1-a07d-9ac9dba628d2	\N	registration-recaptcha-action	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	d7da4c67-d822-4f53-a05a-204d841018c5	3	60	f	\N	\N
0c9aad8c-fa44-4f4c-a030-68b9c44153e2	\N	reset-credentials-choose-user	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	af548bc4-9343-4e54-8106-cb6ec67652da	0	10	f	\N	\N
2af6762c-caf3-4ace-a6ec-cbae179a4587	\N	reset-credential-email	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	af548bc4-9343-4e54-8106-cb6ec67652da	0	20	f	\N	\N
f710487e-cfbd-4e50-b832-4d72a9afa160	\N	reset-password	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	af548bc4-9343-4e54-8106-cb6ec67652da	0	30	f	\N	\N
7322c667-0df2-413a-83bb-6d954833389b	\N	\N	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	af548bc4-9343-4e54-8106-cb6ec67652da	1	40	t	612c31c3-00c5-425b-81a7-a28abbd19085	\N
a17e3f22-154d-4ec5-9ed7-28f4fb751b28	\N	conditional-user-configured	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	612c31c3-00c5-425b-81a7-a28abbd19085	0	10	f	\N	\N
54ab0c6d-3dca-4cc6-8ada-a08e173dd033	\N	reset-otp	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	612c31c3-00c5-425b-81a7-a28abbd19085	0	20	f	\N	\N
6e108832-c02c-4fca-94b2-4254734c516b	\N	client-secret	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	08f31a64-6626-4b24-9ed3-b1b7825ec9e3	2	10	f	\N	\N
a239df04-4c9e-41ec-a86d-8cbbb3baccc8	\N	client-jwt	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	08f31a64-6626-4b24-9ed3-b1b7825ec9e3	2	20	f	\N	\N
e639eaf6-c3d9-4237-a909-c3486ef34ca2	\N	client-secret-jwt	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	08f31a64-6626-4b24-9ed3-b1b7825ec9e3	2	30	f	\N	\N
8934081e-50c5-4de1-b7d0-3d1ab56ad00d	\N	client-x509	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	08f31a64-6626-4b24-9ed3-b1b7825ec9e3	2	40	f	\N	\N
beefee77-8926-4733-bd51-b948b622674e	\N	idp-review-profile	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	a72a0dc5-4baf-482b-b362-aa05d1f4746e	0	10	f	\N	82674a9e-d23d-44d9-a5f6-0d6a2d087aff
5386d36d-7dc3-440d-8238-982ee5cfeec1	\N	\N	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	a72a0dc5-4baf-482b-b362-aa05d1f4746e	0	20	t	1be70fb2-ea9a-421c-9b91-32db84bfe783	\N
92527570-2792-4e0d-b0b8-36097d96fdb2	\N	idp-create-user-if-unique	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	1be70fb2-ea9a-421c-9b91-32db84bfe783	2	10	f	\N	9f6879e3-ebe5-42f8-bc7c-1c9f125f4c73
b8df2907-b76d-4d2d-a2d2-0a4027df0c38	\N	\N	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	1be70fb2-ea9a-421c-9b91-32db84bfe783	2	20	t	9ac9c334-c8dd-4e17-bf4b-52ec97f52e3b	\N
78821124-3afd-42d1-befd-34ed336b1b10	\N	idp-confirm-link	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	9ac9c334-c8dd-4e17-bf4b-52ec97f52e3b	0	10	f	\N	\N
c107c1d0-3249-41fb-a437-7846f9d3644f	\N	\N	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	9ac9c334-c8dd-4e17-bf4b-52ec97f52e3b	0	20	t	340c832a-85e9-4aed-8a9c-f9eacf4a6a7c	\N
7388490a-e25c-46a7-a25f-970a53e1409a	\N	idp-email-verification	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	340c832a-85e9-4aed-8a9c-f9eacf4a6a7c	2	10	f	\N	\N
c2d90587-6009-47fd-9f18-1e2e2c6fc023	\N	\N	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	340c832a-85e9-4aed-8a9c-f9eacf4a6a7c	2	20	t	237bc9c3-47ba-49f4-a997-8010157987cc	\N
06851601-7963-43c9-840d-2a067bcac6ad	\N	idp-username-password-form	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	237bc9c3-47ba-49f4-a997-8010157987cc	0	10	f	\N	\N
e19237cf-eb6d-4b92-9113-42c961a1b951	\N	\N	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	237bc9c3-47ba-49f4-a997-8010157987cc	1	20	t	d156e0a6-d345-4464-9856-992aa431242d	\N
b33d0e22-27b5-488e-8bac-fdef08771a23	\N	conditional-user-configured	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	d156e0a6-d345-4464-9856-992aa431242d	0	10	f	\N	\N
ac3110d6-5f5a-49fe-a91c-368a106009ac	\N	auth-otp-form	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	d156e0a6-d345-4464-9856-992aa431242d	0	20	f	\N	\N
39b0d812-b556-4cc9-9654-b7547270eade	\N	http-basic-authenticator	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	e225dc43-7aec-49fc-a77d-7a077f1c4bf9	0	10	f	\N	\N
7d3f7bdb-d99a-470a-b4dd-3f52f6a66c2f	\N	docker-http-basic-authenticator	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0c95b43c-bea8-455e-9c98-b84c73a6ff65	0	10	f	\N	\N
31b11ebd-f076-44c8-85b8-4a610905b9f6	\N	no-cookie-redirect	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	1ad34535-50c8-4b98-b28f-8295e8c6ebc9	0	10	f	\N	\N
4dfef970-b84f-4943-93c8-b1da5f64c735	\N	\N	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	1ad34535-50c8-4b98-b28f-8295e8c6ebc9	0	20	t	44f3b46b-8068-4532-804e-2173b5566dc8	\N
5958c078-928c-4b1d-bc07-fc64cc7ae30f	\N	basic-auth	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	44f3b46b-8068-4532-804e-2173b5566dc8	0	10	f	\N	\N
00436db4-261f-46d0-91cf-30388105ba9c	\N	basic-auth-otp	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	44f3b46b-8068-4532-804e-2173b5566dc8	3	20	f	\N	\N
84049df7-c3a8-4582-8c82-b5f4047ed3b6	\N	auth-spnego	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	44f3b46b-8068-4532-804e-2173b5566dc8	3	30	f	\N	\N
7ffdc0da-ea45-43f1-88a9-a9d59f805fea	\N	auth-cookie	test	c9057b2c-eaa1-4071-b9f8-229eb21c5dcb	2	10	f	\N	\N
7605d232-a282-4374-b9e4-ccd3088033bc	\N	auth-spnego	test	c9057b2c-eaa1-4071-b9f8-229eb21c5dcb	3	20	f	\N	\N
93349ee5-da4e-42f4-8293-04eed1326151	\N	identity-provider-redirector	test	c9057b2c-eaa1-4071-b9f8-229eb21c5dcb	2	25	f	\N	\N
5356da50-3612-4803-bd8c-eb7231dd58f3	\N	\N	test	c9057b2c-eaa1-4071-b9f8-229eb21c5dcb	2	30	t	6e932bcd-4240-45f0-92a2-917ceb4c4d4f	\N
5188be01-1efd-4c62-b14e-7a820954148b	\N	auth-username-password-form	test	6e932bcd-4240-45f0-92a2-917ceb4c4d4f	0	10	f	\N	\N
7a1b4dd6-72a7-4bf1-8cd2-d561e3190cb6	\N	\N	test	6e932bcd-4240-45f0-92a2-917ceb4c4d4f	1	20	t	70e6f5bb-1d57-4c57-8dde-6f2806ba9598	\N
40ad5bcd-11cb-4e32-81ab-28b1de25c0bc	\N	conditional-user-configured	test	70e6f5bb-1d57-4c57-8dde-6f2806ba9598	0	10	f	\N	\N
345ff4e5-1704-4810-ae20-b9f58dd49120	\N	auth-otp-form	test	70e6f5bb-1d57-4c57-8dde-6f2806ba9598	0	20	f	\N	\N
9d14b810-ea25-492e-81b7-f52a2762f0b0	\N	direct-grant-validate-username	test	f1b9edda-64ca-4227-8762-4e229099cb77	0	10	f	\N	\N
91290653-6e0d-4fd7-89d4-095fafa20575	\N	direct-grant-validate-password	test	f1b9edda-64ca-4227-8762-4e229099cb77	0	20	f	\N	\N
44542688-e3f9-4510-9666-7c250be85d5d	\N	\N	test	f1b9edda-64ca-4227-8762-4e229099cb77	1	30	t	d0a89d0b-16b8-4c05-8fa3-314cdcd3291d	\N
64437ffe-108e-4d58-a073-1a0c0dc8206f	\N	conditional-user-configured	test	d0a89d0b-16b8-4c05-8fa3-314cdcd3291d	0	10	f	\N	\N
f04890c7-e343-4ae3-b5ef-313c873edc19	\N	direct-grant-validate-otp	test	d0a89d0b-16b8-4c05-8fa3-314cdcd3291d	0	20	f	\N	\N
3251d33e-e657-4016-837d-4c2e4e8e3948	\N	registration-page-form	test	be54944e-8a5a-45f0-a9ea-e52f07fdaf15	0	10	t	5a7a1ef2-571d-4753-917b-ccf10a48231b	\N
b779abce-2ad1-463d-a4e4-7884c3165370	\N	registration-user-creation	test	5a7a1ef2-571d-4753-917b-ccf10a48231b	0	20	f	\N	\N
cae4c676-94ee-47fe-833e-9321d7859214	\N	registration-profile-action	test	5a7a1ef2-571d-4753-917b-ccf10a48231b	0	40	f	\N	\N
ba4a173e-ab82-41fa-91ea-ee18ba82b41c	\N	registration-password-action	test	5a7a1ef2-571d-4753-917b-ccf10a48231b	0	50	f	\N	\N
47fbb494-8b97-4a5d-9cea-53328b7e3dbf	\N	registration-recaptcha-action	test	5a7a1ef2-571d-4753-917b-ccf10a48231b	3	60	f	\N	\N
1a6d6f1f-a7a1-4a4c-8897-9ea4d2ed7153	\N	reset-credentials-choose-user	test	2b094ddb-106d-42b1-b8ed-c721b9899573	0	10	f	\N	\N
d29e4f2a-1648-458e-bd90-2d67ca522d31	\N	reset-credential-email	test	2b094ddb-106d-42b1-b8ed-c721b9899573	0	20	f	\N	\N
d0d71f44-90f8-4bd4-934e-19cf59249020	\N	reset-password	test	2b094ddb-106d-42b1-b8ed-c721b9899573	0	30	f	\N	\N
d161850c-4a98-4189-b1aa-70f7deafd8c3	\N	\N	test	2b094ddb-106d-42b1-b8ed-c721b9899573	1	40	t	0dfbb8b0-eac2-4f81-abda-7b153c64c3d1	\N
0ff7a3c5-ee1c-4126-88b5-fef00f666133	\N	conditional-user-configured	test	0dfbb8b0-eac2-4f81-abda-7b153c64c3d1	0	10	f	\N	\N
0e24680c-0938-4ed9-87a1-5d248fd621dc	\N	reset-otp	test	0dfbb8b0-eac2-4f81-abda-7b153c64c3d1	0	20	f	\N	\N
168f4167-cdf7-48c4-ae70-b927211ae06b	\N	client-secret	test	c1440149-acf8-484f-98fb-cc1eaf243d75	2	10	f	\N	\N
a7cc958d-1e1e-4ca0-b2c5-f39980785107	\N	client-jwt	test	c1440149-acf8-484f-98fb-cc1eaf243d75	2	20	f	\N	\N
0af492cf-a216-43b2-8fd9-6aa6ae4860b1	\N	client-secret-jwt	test	c1440149-acf8-484f-98fb-cc1eaf243d75	2	30	f	\N	\N
5024eb39-8568-4d71-8c24-42392cfa4d36	\N	client-x509	test	c1440149-acf8-484f-98fb-cc1eaf243d75	2	40	f	\N	\N
96100b22-f2f9-409e-96e0-894ff0aa961d	\N	idp-review-profile	test	0606ca85-60b0-4fd1-bc54-215481bccc48	0	10	f	\N	45827f92-189f-47c5-a4f0-8d0377cfaf89
d11e151a-4ffb-44b0-934b-6c8f4720d7d9	\N	\N	test	0606ca85-60b0-4fd1-bc54-215481bccc48	0	20	t	f848169b-aafd-4b2c-8125-c87d4cc3d894	\N
4135c1dc-0e8e-4bf1-b4d5-5ddef074be29	\N	idp-create-user-if-unique	test	f848169b-aafd-4b2c-8125-c87d4cc3d894	2	10	f	\N	8ac81e49-1661-4e60-b5d8-c96bb4467600
1b815e6a-356a-46dc-9c4c-88b1e62ef23b	\N	\N	test	f848169b-aafd-4b2c-8125-c87d4cc3d894	2	20	t	5f56ba35-075d-4144-9334-d95b8a3bfc59	\N
6657c10a-612e-4ebf-94b2-b55f62085f2a	\N	idp-confirm-link	test	5f56ba35-075d-4144-9334-d95b8a3bfc59	0	10	f	\N	\N
86da9cba-c1a0-4668-890a-960e9a93101d	\N	\N	test	5f56ba35-075d-4144-9334-d95b8a3bfc59	0	20	t	c1fa4cfb-b942-48d3-abc8-4ba8ae3b2f00	\N
2cfa8596-c02b-46ce-9c36-c2cc0cae8179	\N	idp-email-verification	test	c1fa4cfb-b942-48d3-abc8-4ba8ae3b2f00	2	10	f	\N	\N
ba14dc21-a74c-40fe-8dff-c9e44ec7891b	\N	\N	test	c1fa4cfb-b942-48d3-abc8-4ba8ae3b2f00	2	20	t	2c0b4a27-9544-4a60-ba6c-7c28f94b6fd8	\N
259d53b4-ac96-4e35-a12f-39fd7e892798	\N	idp-username-password-form	test	2c0b4a27-9544-4a60-ba6c-7c28f94b6fd8	0	10	f	\N	\N
352e5cc4-9a2d-45f0-a718-bb3f9d0d0643	\N	\N	test	2c0b4a27-9544-4a60-ba6c-7c28f94b6fd8	1	20	t	6dcc23e7-e91b-45b4-bb65-42cc3e3a5f35	\N
d3d1a7b9-2c49-4b9b-ad2e-02c3b41b4cee	\N	conditional-user-configured	test	6dcc23e7-e91b-45b4-bb65-42cc3e3a5f35	0	10	f	\N	\N
a1f57ab3-1fb5-42a9-8894-5af27ed7d258	\N	auth-otp-form	test	6dcc23e7-e91b-45b4-bb65-42cc3e3a5f35	0	20	f	\N	\N
52a58234-35c4-41b7-bc56-374dd1fa3bc1	\N	http-basic-authenticator	test	8cb485ef-4a0e-4a46-9548-34cd917187f9	0	10	f	\N	\N
a89b9320-7d15-4b05-9863-4a37f1dc5d08	\N	docker-http-basic-authenticator	test	3ba7c4a0-e6a7-42ba-be5e-6eb2f8e324b9	0	10	f	\N	\N
bd362e57-88e2-4576-9ac7-38fa4951ac34	\N	no-cookie-redirect	test	e11ab55f-8b9d-4334-940a-6e09faaed17c	0	10	f	\N	\N
a28ba52a-b169-4ff0-897e-650ed79a3554	\N	\N	test	e11ab55f-8b9d-4334-940a-6e09faaed17c	0	20	t	bca965a0-5dd0-46fa-ae01-f2e040f6a027	\N
3ad052fb-2c3a-431e-96f9-2319e6fafb73	\N	basic-auth	test	bca965a0-5dd0-46fa-ae01-f2e040f6a027	0	10	f	\N	\N
b1202957-edac-43bd-8eb6-524c6d30b369	\N	basic-auth-otp	test	bca965a0-5dd0-46fa-ae01-f2e040f6a027	3	20	f	\N	\N
4f854120-852e-4735-9b7b-0abbece42743	\N	auth-spnego	test	bca965a0-5dd0-46fa-ae01-f2e040f6a027	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
2176bd5a-7258-4f22-91c7-8e082f45f4ce	browser	browser based authentication	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	t	t
81b8dd1b-f8e0-4834-bd91-ada711a2ae9f	forms	Username, password, otp and other auth forms.	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	f	t
8d1971fa-2e45-43b2-b861-8a985e5649b3	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	f	t
3df2e182-a333-4a71-92db-c7a5dd12b45e	direct grant	OpenID Connect Resource Owner Grant	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	t	t
712873ea-ce88-4795-82fb-ad63eaa27183	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	f	t
a40418aa-f3ac-48a9-a074-b4857d96284f	registration	registration flow	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	t	t
d7da4c67-d822-4f53-a05a-204d841018c5	registration form	registration form	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	form-flow	f	t
af548bc4-9343-4e54-8106-cb6ec67652da	reset credentials	Reset credentials for a user if they forgot their password or something	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	t	t
612c31c3-00c5-425b-81a7-a28abbd19085	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	f	t
08f31a64-6626-4b24-9ed3-b1b7825ec9e3	clients	Base authentication for clients	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	client-flow	t	t
a72a0dc5-4baf-482b-b362-aa05d1f4746e	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	t	t
1be70fb2-ea9a-421c-9b91-32db84bfe783	User creation or linking	Flow for the existing/non-existing user alternatives	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	f	t
9ac9c334-c8dd-4e17-bf4b-52ec97f52e3b	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	f	t
340c832a-85e9-4aed-8a9c-f9eacf4a6a7c	Account verification options	Method with which to verity the existing account	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	f	t
237bc9c3-47ba-49f4-a997-8010157987cc	Verify Existing Account by Re-authentication	Reauthentication of existing account	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	f	t
d156e0a6-d345-4464-9856-992aa431242d	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	f	t
e225dc43-7aec-49fc-a77d-7a077f1c4bf9	saml ecp	SAML ECP Profile Authentication Flow	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	t	t
0c95b43c-bea8-455e-9c98-b84c73a6ff65	docker auth	Used by Docker clients to authenticate against the IDP	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	t	t
1ad34535-50c8-4b98-b28f-8295e8c6ebc9	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	t	t
44f3b46b-8068-4532-804e-2173b5566dc8	Authentication Options	Authentication options.	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	basic-flow	f	t
c9057b2c-eaa1-4071-b9f8-229eb21c5dcb	browser	browser based authentication	test	basic-flow	t	t
6e932bcd-4240-45f0-92a2-917ceb4c4d4f	forms	Username, password, otp and other auth forms.	test	basic-flow	f	t
70e6f5bb-1d57-4c57-8dde-6f2806ba9598	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	test	basic-flow	f	t
f1b9edda-64ca-4227-8762-4e229099cb77	direct grant	OpenID Connect Resource Owner Grant	test	basic-flow	t	t
d0a89d0b-16b8-4c05-8fa3-314cdcd3291d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	test	basic-flow	f	t
be54944e-8a5a-45f0-a9ea-e52f07fdaf15	registration	registration flow	test	basic-flow	t	t
5a7a1ef2-571d-4753-917b-ccf10a48231b	registration form	registration form	test	form-flow	f	t
2b094ddb-106d-42b1-b8ed-c721b9899573	reset credentials	Reset credentials for a user if they forgot their password or something	test	basic-flow	t	t
0dfbb8b0-eac2-4f81-abda-7b153c64c3d1	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	test	basic-flow	f	t
c1440149-acf8-484f-98fb-cc1eaf243d75	clients	Base authentication for clients	test	client-flow	t	t
0606ca85-60b0-4fd1-bc54-215481bccc48	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	test	basic-flow	t	t
f848169b-aafd-4b2c-8125-c87d4cc3d894	User creation or linking	Flow for the existing/non-existing user alternatives	test	basic-flow	f	t
5f56ba35-075d-4144-9334-d95b8a3bfc59	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	test	basic-flow	f	t
c1fa4cfb-b942-48d3-abc8-4ba8ae3b2f00	Account verification options	Method with which to verity the existing account	test	basic-flow	f	t
2c0b4a27-9544-4a60-ba6c-7c28f94b6fd8	Verify Existing Account by Re-authentication	Reauthentication of existing account	test	basic-flow	f	t
6dcc23e7-e91b-45b4-bb65-42cc3e3a5f35	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	test	basic-flow	f	t
8cb485ef-4a0e-4a46-9548-34cd917187f9	saml ecp	SAML ECP Profile Authentication Flow	test	basic-flow	t	t
3ba7c4a0-e6a7-42ba-be5e-6eb2f8e324b9	docker auth	Used by Docker clients to authenticate against the IDP	test	basic-flow	t	t
e11ab55f-8b9d-4334-940a-6e09faaed17c	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	test	basic-flow	t	t
bca965a0-5dd0-46fa-ae01-f2e040f6a027	Authentication Options	Authentication options.	test	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
82674a9e-d23d-44d9-a5f6-0d6a2d087aff	review profile config	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45
9f6879e3-ebe5-42f8-bc7c-1c9f125f4c73	create unique user config	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45
45827f92-189f-47c5-a4f0-8d0377cfaf89	review profile config	test
8ac81e49-1661-4e60-b5d8-c96bb4467600	create unique user config	test
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
82674a9e-d23d-44d9-a5f6-0d6a2d087aff	missing	update.profile.on.first.login
9f6879e3-ebe5-42f8-bc7c-1c9f125f4c73	false	require.password.update.after.registration
45827f92-189f-47c5-a4f0-8d0377cfaf89	missing	update.profile.on.first.login
8ac81e49-1661-4e60-b5d8-c96bb4467600	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	f	master-realm	0	f	\N	\N	t	\N	f	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
65465689-8e6f-4ee5-8cd5-353c9e715b51	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
df65ddb1-74e2-4763-9ef8-598d4eea9120	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
3a103147-3781-4a74-912c-07dea281508b	t	f	broker	0	f	\N	\N	t	\N	f	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
e48a8fee-4299-444c-915b-f68d37bbf1fd	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
d6a40169-bc3b-4c23-a124-7277df9a74be	t	f	admin-cli	0	t	\N	\N	f	\N	f	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
845688f8-735c-4c14-a109-ea8a171d0ca7	t	f	test-realm	0	f	\N	\N	t	\N	f	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N	0	f	f	test Realm	f	client-secret	\N	\N	\N	t	f	f	f
a4f024b5-eb59-49b7-a181-e3d551907e79	t	f	realm-management	0	f	\N	\N	t	\N	f	test	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
e4d55cb1-1907-44fc-a203-e16d9dd48c4c	t	f	account	0	t	\N	/realms/test/account/	f	\N	f	test	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
02db0790-23bc-49ac-bee0-5fae3c56f316	t	f	account-console	0	t	\N	/realms/test/account/	f	\N	f	test	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
34f13e08-8694-4912-b3fa-891a8c10c501	t	f	broker	0	f	\N	\N	t	\N	f	test	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
5a3f72bf-aacd-4096-b3fb-4065b7f31083	t	f	security-admin-console	0	t	\N	/admin/test/console/	f	\N	f	test	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
9172e359-e2bb-47a4-8448-4703137b01c5	t	f	admin-cli	0	t	\N	\N	f	\N	f	test	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
df65ddb1-74e2-4763-9ef8-598d4eea9120	S256	pkce.code.challenge.method
e48a8fee-4299-444c-915b-f68d37bbf1fd	S256	pkce.code.challenge.method
02db0790-23bc-49ac-bee0-5fae3c56f316	S256	pkce.code.challenge.method
5a3f72bf-aacd-4096-b3fb-4065b7f31083	S256	pkce.code.challenge.method
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
7994d91d-57f1-4bc4-85a4-890e1902b0a6	offline_access	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	OpenID Connect built-in scope: offline_access	openid-connect
af51769a-bda1-4a90-b02c-c94869683f6f	role_list	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	SAML role list	saml
daaca0cf-b188-4b18-9aa4-034d4cd520f5	profile	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	OpenID Connect built-in scope: profile	openid-connect
2882b34f-51ea-46fc-942d-42c538a0273f	email	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	OpenID Connect built-in scope: email	openid-connect
b6e78155-3230-48bf-926f-42810df57221	address	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	OpenID Connect built-in scope: address	openid-connect
d8975a12-e354-4238-b7a2-0591608b4ea7	phone	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	OpenID Connect built-in scope: phone	openid-connect
40912194-5035-4bc0-b6c7-d757bf59238c	roles	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	OpenID Connect scope for add user roles to the access token	openid-connect
082bd494-02e2-4528-ae06-a46b608f4984	web-origins	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	OpenID Connect scope for add allowed web origins to the access token	openid-connect
2655b3cd-512e-4b3c-b75b-f436ba6b3dc3	microprofile-jwt	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	Microprofile - JWT built-in scope	openid-connect
36fb8f6a-6640-45ab-a7f1-04b7d7563179	acr	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
0f30651e-7405-4704-b7bf-a2474bb84359	offline_access	test	OpenID Connect built-in scope: offline_access	openid-connect
5f9763f7-e859-4460-a729-891db0d53f67	role_list	test	SAML role list	saml
0153ea9f-e3be-44a7-9168-2f48fe701d40	profile	test	OpenID Connect built-in scope: profile	openid-connect
c9bc44e8-084d-4244-846b-888512b9e68c	email	test	OpenID Connect built-in scope: email	openid-connect
d7a41e7f-ab51-4f26-99fc-449229dc6a82	address	test	OpenID Connect built-in scope: address	openid-connect
59c13612-9b23-4e7c-ad68-128ab9644df4	phone	test	OpenID Connect built-in scope: phone	openid-connect
a7636dab-db04-4308-9aca-fc43a510fad2	roles	test	OpenID Connect scope for add user roles to the access token	openid-connect
cd7eac36-2798-44ed-ad14-c071f00ad0b2	web-origins	test	OpenID Connect scope for add allowed web origins to the access token	openid-connect
5eaf5b65-1031-4831-bf00-8db3746d8e28	microprofile-jwt	test	Microprofile - JWT built-in scope	openid-connect
61c9941a-cbbe-4e1b-8563-2bd9036485d8	acr	test	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
7994d91d-57f1-4bc4-85a4-890e1902b0a6	true	display.on.consent.screen
7994d91d-57f1-4bc4-85a4-890e1902b0a6	${offlineAccessScopeConsentText}	consent.screen.text
af51769a-bda1-4a90-b02c-c94869683f6f	true	display.on.consent.screen
af51769a-bda1-4a90-b02c-c94869683f6f	${samlRoleListScopeConsentText}	consent.screen.text
daaca0cf-b188-4b18-9aa4-034d4cd520f5	true	display.on.consent.screen
daaca0cf-b188-4b18-9aa4-034d4cd520f5	${profileScopeConsentText}	consent.screen.text
daaca0cf-b188-4b18-9aa4-034d4cd520f5	true	include.in.token.scope
2882b34f-51ea-46fc-942d-42c538a0273f	true	display.on.consent.screen
2882b34f-51ea-46fc-942d-42c538a0273f	${emailScopeConsentText}	consent.screen.text
2882b34f-51ea-46fc-942d-42c538a0273f	true	include.in.token.scope
b6e78155-3230-48bf-926f-42810df57221	true	display.on.consent.screen
b6e78155-3230-48bf-926f-42810df57221	${addressScopeConsentText}	consent.screen.text
b6e78155-3230-48bf-926f-42810df57221	true	include.in.token.scope
d8975a12-e354-4238-b7a2-0591608b4ea7	true	display.on.consent.screen
d8975a12-e354-4238-b7a2-0591608b4ea7	${phoneScopeConsentText}	consent.screen.text
d8975a12-e354-4238-b7a2-0591608b4ea7	true	include.in.token.scope
40912194-5035-4bc0-b6c7-d757bf59238c	true	display.on.consent.screen
40912194-5035-4bc0-b6c7-d757bf59238c	${rolesScopeConsentText}	consent.screen.text
40912194-5035-4bc0-b6c7-d757bf59238c	false	include.in.token.scope
082bd494-02e2-4528-ae06-a46b608f4984	false	display.on.consent.screen
082bd494-02e2-4528-ae06-a46b608f4984		consent.screen.text
082bd494-02e2-4528-ae06-a46b608f4984	false	include.in.token.scope
2655b3cd-512e-4b3c-b75b-f436ba6b3dc3	false	display.on.consent.screen
2655b3cd-512e-4b3c-b75b-f436ba6b3dc3	true	include.in.token.scope
36fb8f6a-6640-45ab-a7f1-04b7d7563179	false	display.on.consent.screen
36fb8f6a-6640-45ab-a7f1-04b7d7563179	false	include.in.token.scope
0f30651e-7405-4704-b7bf-a2474bb84359	true	display.on.consent.screen
0f30651e-7405-4704-b7bf-a2474bb84359	${offlineAccessScopeConsentText}	consent.screen.text
5f9763f7-e859-4460-a729-891db0d53f67	true	display.on.consent.screen
5f9763f7-e859-4460-a729-891db0d53f67	${samlRoleListScopeConsentText}	consent.screen.text
0153ea9f-e3be-44a7-9168-2f48fe701d40	true	display.on.consent.screen
0153ea9f-e3be-44a7-9168-2f48fe701d40	${profileScopeConsentText}	consent.screen.text
0153ea9f-e3be-44a7-9168-2f48fe701d40	true	include.in.token.scope
c9bc44e8-084d-4244-846b-888512b9e68c	true	display.on.consent.screen
c9bc44e8-084d-4244-846b-888512b9e68c	${emailScopeConsentText}	consent.screen.text
c9bc44e8-084d-4244-846b-888512b9e68c	true	include.in.token.scope
d7a41e7f-ab51-4f26-99fc-449229dc6a82	true	display.on.consent.screen
d7a41e7f-ab51-4f26-99fc-449229dc6a82	${addressScopeConsentText}	consent.screen.text
d7a41e7f-ab51-4f26-99fc-449229dc6a82	true	include.in.token.scope
59c13612-9b23-4e7c-ad68-128ab9644df4	true	display.on.consent.screen
59c13612-9b23-4e7c-ad68-128ab9644df4	${phoneScopeConsentText}	consent.screen.text
59c13612-9b23-4e7c-ad68-128ab9644df4	true	include.in.token.scope
a7636dab-db04-4308-9aca-fc43a510fad2	true	display.on.consent.screen
a7636dab-db04-4308-9aca-fc43a510fad2	${rolesScopeConsentText}	consent.screen.text
a7636dab-db04-4308-9aca-fc43a510fad2	false	include.in.token.scope
cd7eac36-2798-44ed-ad14-c071f00ad0b2	false	display.on.consent.screen
cd7eac36-2798-44ed-ad14-c071f00ad0b2		consent.screen.text
cd7eac36-2798-44ed-ad14-c071f00ad0b2	false	include.in.token.scope
5eaf5b65-1031-4831-bf00-8db3746d8e28	false	display.on.consent.screen
5eaf5b65-1031-4831-bf00-8db3746d8e28	true	include.in.token.scope
61c9941a-cbbe-4e1b-8563-2bd9036485d8	false	display.on.consent.screen
61c9941a-cbbe-4e1b-8563-2bd9036485d8	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
65465689-8e6f-4ee5-8cd5-353c9e715b51	2882b34f-51ea-46fc-942d-42c538a0273f	t
65465689-8e6f-4ee5-8cd5-353c9e715b51	36fb8f6a-6640-45ab-a7f1-04b7d7563179	t
65465689-8e6f-4ee5-8cd5-353c9e715b51	082bd494-02e2-4528-ae06-a46b608f4984	t
65465689-8e6f-4ee5-8cd5-353c9e715b51	daaca0cf-b188-4b18-9aa4-034d4cd520f5	t
65465689-8e6f-4ee5-8cd5-353c9e715b51	40912194-5035-4bc0-b6c7-d757bf59238c	t
65465689-8e6f-4ee5-8cd5-353c9e715b51	7994d91d-57f1-4bc4-85a4-890e1902b0a6	f
65465689-8e6f-4ee5-8cd5-353c9e715b51	d8975a12-e354-4238-b7a2-0591608b4ea7	f
65465689-8e6f-4ee5-8cd5-353c9e715b51	b6e78155-3230-48bf-926f-42810df57221	f
65465689-8e6f-4ee5-8cd5-353c9e715b51	2655b3cd-512e-4b3c-b75b-f436ba6b3dc3	f
df65ddb1-74e2-4763-9ef8-598d4eea9120	2882b34f-51ea-46fc-942d-42c538a0273f	t
df65ddb1-74e2-4763-9ef8-598d4eea9120	36fb8f6a-6640-45ab-a7f1-04b7d7563179	t
df65ddb1-74e2-4763-9ef8-598d4eea9120	082bd494-02e2-4528-ae06-a46b608f4984	t
df65ddb1-74e2-4763-9ef8-598d4eea9120	daaca0cf-b188-4b18-9aa4-034d4cd520f5	t
df65ddb1-74e2-4763-9ef8-598d4eea9120	40912194-5035-4bc0-b6c7-d757bf59238c	t
df65ddb1-74e2-4763-9ef8-598d4eea9120	7994d91d-57f1-4bc4-85a4-890e1902b0a6	f
df65ddb1-74e2-4763-9ef8-598d4eea9120	d8975a12-e354-4238-b7a2-0591608b4ea7	f
df65ddb1-74e2-4763-9ef8-598d4eea9120	b6e78155-3230-48bf-926f-42810df57221	f
df65ddb1-74e2-4763-9ef8-598d4eea9120	2655b3cd-512e-4b3c-b75b-f436ba6b3dc3	f
d6a40169-bc3b-4c23-a124-7277df9a74be	2882b34f-51ea-46fc-942d-42c538a0273f	t
d6a40169-bc3b-4c23-a124-7277df9a74be	36fb8f6a-6640-45ab-a7f1-04b7d7563179	t
d6a40169-bc3b-4c23-a124-7277df9a74be	082bd494-02e2-4528-ae06-a46b608f4984	t
d6a40169-bc3b-4c23-a124-7277df9a74be	daaca0cf-b188-4b18-9aa4-034d4cd520f5	t
d6a40169-bc3b-4c23-a124-7277df9a74be	40912194-5035-4bc0-b6c7-d757bf59238c	t
d6a40169-bc3b-4c23-a124-7277df9a74be	7994d91d-57f1-4bc4-85a4-890e1902b0a6	f
d6a40169-bc3b-4c23-a124-7277df9a74be	d8975a12-e354-4238-b7a2-0591608b4ea7	f
d6a40169-bc3b-4c23-a124-7277df9a74be	b6e78155-3230-48bf-926f-42810df57221	f
d6a40169-bc3b-4c23-a124-7277df9a74be	2655b3cd-512e-4b3c-b75b-f436ba6b3dc3	f
3a103147-3781-4a74-912c-07dea281508b	2882b34f-51ea-46fc-942d-42c538a0273f	t
3a103147-3781-4a74-912c-07dea281508b	36fb8f6a-6640-45ab-a7f1-04b7d7563179	t
3a103147-3781-4a74-912c-07dea281508b	082bd494-02e2-4528-ae06-a46b608f4984	t
3a103147-3781-4a74-912c-07dea281508b	daaca0cf-b188-4b18-9aa4-034d4cd520f5	t
3a103147-3781-4a74-912c-07dea281508b	40912194-5035-4bc0-b6c7-d757bf59238c	t
3a103147-3781-4a74-912c-07dea281508b	7994d91d-57f1-4bc4-85a4-890e1902b0a6	f
3a103147-3781-4a74-912c-07dea281508b	d8975a12-e354-4238-b7a2-0591608b4ea7	f
3a103147-3781-4a74-912c-07dea281508b	b6e78155-3230-48bf-926f-42810df57221	f
3a103147-3781-4a74-912c-07dea281508b	2655b3cd-512e-4b3c-b75b-f436ba6b3dc3	f
0529c703-ef05-4a9a-8d6a-54270d8af0f6	2882b34f-51ea-46fc-942d-42c538a0273f	t
0529c703-ef05-4a9a-8d6a-54270d8af0f6	36fb8f6a-6640-45ab-a7f1-04b7d7563179	t
0529c703-ef05-4a9a-8d6a-54270d8af0f6	082bd494-02e2-4528-ae06-a46b608f4984	t
0529c703-ef05-4a9a-8d6a-54270d8af0f6	daaca0cf-b188-4b18-9aa4-034d4cd520f5	t
0529c703-ef05-4a9a-8d6a-54270d8af0f6	40912194-5035-4bc0-b6c7-d757bf59238c	t
0529c703-ef05-4a9a-8d6a-54270d8af0f6	7994d91d-57f1-4bc4-85a4-890e1902b0a6	f
0529c703-ef05-4a9a-8d6a-54270d8af0f6	d8975a12-e354-4238-b7a2-0591608b4ea7	f
0529c703-ef05-4a9a-8d6a-54270d8af0f6	b6e78155-3230-48bf-926f-42810df57221	f
0529c703-ef05-4a9a-8d6a-54270d8af0f6	2655b3cd-512e-4b3c-b75b-f436ba6b3dc3	f
e48a8fee-4299-444c-915b-f68d37bbf1fd	2882b34f-51ea-46fc-942d-42c538a0273f	t
e48a8fee-4299-444c-915b-f68d37bbf1fd	36fb8f6a-6640-45ab-a7f1-04b7d7563179	t
e48a8fee-4299-444c-915b-f68d37bbf1fd	082bd494-02e2-4528-ae06-a46b608f4984	t
e48a8fee-4299-444c-915b-f68d37bbf1fd	daaca0cf-b188-4b18-9aa4-034d4cd520f5	t
e48a8fee-4299-444c-915b-f68d37bbf1fd	40912194-5035-4bc0-b6c7-d757bf59238c	t
e48a8fee-4299-444c-915b-f68d37bbf1fd	7994d91d-57f1-4bc4-85a4-890e1902b0a6	f
e48a8fee-4299-444c-915b-f68d37bbf1fd	d8975a12-e354-4238-b7a2-0591608b4ea7	f
e48a8fee-4299-444c-915b-f68d37bbf1fd	b6e78155-3230-48bf-926f-42810df57221	f
e48a8fee-4299-444c-915b-f68d37bbf1fd	2655b3cd-512e-4b3c-b75b-f436ba6b3dc3	f
e4d55cb1-1907-44fc-a203-e16d9dd48c4c	a7636dab-db04-4308-9aca-fc43a510fad2	t
e4d55cb1-1907-44fc-a203-e16d9dd48c4c	61c9941a-cbbe-4e1b-8563-2bd9036485d8	t
e4d55cb1-1907-44fc-a203-e16d9dd48c4c	0153ea9f-e3be-44a7-9168-2f48fe701d40	t
e4d55cb1-1907-44fc-a203-e16d9dd48c4c	c9bc44e8-084d-4244-846b-888512b9e68c	t
e4d55cb1-1907-44fc-a203-e16d9dd48c4c	cd7eac36-2798-44ed-ad14-c071f00ad0b2	t
e4d55cb1-1907-44fc-a203-e16d9dd48c4c	5eaf5b65-1031-4831-bf00-8db3746d8e28	f
e4d55cb1-1907-44fc-a203-e16d9dd48c4c	0f30651e-7405-4704-b7bf-a2474bb84359	f
e4d55cb1-1907-44fc-a203-e16d9dd48c4c	d7a41e7f-ab51-4f26-99fc-449229dc6a82	f
e4d55cb1-1907-44fc-a203-e16d9dd48c4c	59c13612-9b23-4e7c-ad68-128ab9644df4	f
02db0790-23bc-49ac-bee0-5fae3c56f316	a7636dab-db04-4308-9aca-fc43a510fad2	t
02db0790-23bc-49ac-bee0-5fae3c56f316	61c9941a-cbbe-4e1b-8563-2bd9036485d8	t
02db0790-23bc-49ac-bee0-5fae3c56f316	0153ea9f-e3be-44a7-9168-2f48fe701d40	t
02db0790-23bc-49ac-bee0-5fae3c56f316	c9bc44e8-084d-4244-846b-888512b9e68c	t
02db0790-23bc-49ac-bee0-5fae3c56f316	cd7eac36-2798-44ed-ad14-c071f00ad0b2	t
02db0790-23bc-49ac-bee0-5fae3c56f316	5eaf5b65-1031-4831-bf00-8db3746d8e28	f
02db0790-23bc-49ac-bee0-5fae3c56f316	0f30651e-7405-4704-b7bf-a2474bb84359	f
02db0790-23bc-49ac-bee0-5fae3c56f316	d7a41e7f-ab51-4f26-99fc-449229dc6a82	f
02db0790-23bc-49ac-bee0-5fae3c56f316	59c13612-9b23-4e7c-ad68-128ab9644df4	f
9172e359-e2bb-47a4-8448-4703137b01c5	a7636dab-db04-4308-9aca-fc43a510fad2	t
9172e359-e2bb-47a4-8448-4703137b01c5	61c9941a-cbbe-4e1b-8563-2bd9036485d8	t
9172e359-e2bb-47a4-8448-4703137b01c5	0153ea9f-e3be-44a7-9168-2f48fe701d40	t
9172e359-e2bb-47a4-8448-4703137b01c5	c9bc44e8-084d-4244-846b-888512b9e68c	t
9172e359-e2bb-47a4-8448-4703137b01c5	cd7eac36-2798-44ed-ad14-c071f00ad0b2	t
9172e359-e2bb-47a4-8448-4703137b01c5	5eaf5b65-1031-4831-bf00-8db3746d8e28	f
9172e359-e2bb-47a4-8448-4703137b01c5	0f30651e-7405-4704-b7bf-a2474bb84359	f
9172e359-e2bb-47a4-8448-4703137b01c5	d7a41e7f-ab51-4f26-99fc-449229dc6a82	f
9172e359-e2bb-47a4-8448-4703137b01c5	59c13612-9b23-4e7c-ad68-128ab9644df4	f
34f13e08-8694-4912-b3fa-891a8c10c501	a7636dab-db04-4308-9aca-fc43a510fad2	t
34f13e08-8694-4912-b3fa-891a8c10c501	61c9941a-cbbe-4e1b-8563-2bd9036485d8	t
34f13e08-8694-4912-b3fa-891a8c10c501	0153ea9f-e3be-44a7-9168-2f48fe701d40	t
34f13e08-8694-4912-b3fa-891a8c10c501	c9bc44e8-084d-4244-846b-888512b9e68c	t
34f13e08-8694-4912-b3fa-891a8c10c501	cd7eac36-2798-44ed-ad14-c071f00ad0b2	t
34f13e08-8694-4912-b3fa-891a8c10c501	5eaf5b65-1031-4831-bf00-8db3746d8e28	f
34f13e08-8694-4912-b3fa-891a8c10c501	0f30651e-7405-4704-b7bf-a2474bb84359	f
34f13e08-8694-4912-b3fa-891a8c10c501	d7a41e7f-ab51-4f26-99fc-449229dc6a82	f
34f13e08-8694-4912-b3fa-891a8c10c501	59c13612-9b23-4e7c-ad68-128ab9644df4	f
a4f024b5-eb59-49b7-a181-e3d551907e79	a7636dab-db04-4308-9aca-fc43a510fad2	t
a4f024b5-eb59-49b7-a181-e3d551907e79	61c9941a-cbbe-4e1b-8563-2bd9036485d8	t
a4f024b5-eb59-49b7-a181-e3d551907e79	0153ea9f-e3be-44a7-9168-2f48fe701d40	t
a4f024b5-eb59-49b7-a181-e3d551907e79	c9bc44e8-084d-4244-846b-888512b9e68c	t
a4f024b5-eb59-49b7-a181-e3d551907e79	cd7eac36-2798-44ed-ad14-c071f00ad0b2	t
a4f024b5-eb59-49b7-a181-e3d551907e79	5eaf5b65-1031-4831-bf00-8db3746d8e28	f
a4f024b5-eb59-49b7-a181-e3d551907e79	0f30651e-7405-4704-b7bf-a2474bb84359	f
a4f024b5-eb59-49b7-a181-e3d551907e79	d7a41e7f-ab51-4f26-99fc-449229dc6a82	f
a4f024b5-eb59-49b7-a181-e3d551907e79	59c13612-9b23-4e7c-ad68-128ab9644df4	f
5a3f72bf-aacd-4096-b3fb-4065b7f31083	a7636dab-db04-4308-9aca-fc43a510fad2	t
5a3f72bf-aacd-4096-b3fb-4065b7f31083	61c9941a-cbbe-4e1b-8563-2bd9036485d8	t
5a3f72bf-aacd-4096-b3fb-4065b7f31083	0153ea9f-e3be-44a7-9168-2f48fe701d40	t
5a3f72bf-aacd-4096-b3fb-4065b7f31083	c9bc44e8-084d-4244-846b-888512b9e68c	t
5a3f72bf-aacd-4096-b3fb-4065b7f31083	cd7eac36-2798-44ed-ad14-c071f00ad0b2	t
5a3f72bf-aacd-4096-b3fb-4065b7f31083	5eaf5b65-1031-4831-bf00-8db3746d8e28	f
5a3f72bf-aacd-4096-b3fb-4065b7f31083	0f30651e-7405-4704-b7bf-a2474bb84359	f
5a3f72bf-aacd-4096-b3fb-4065b7f31083	d7a41e7f-ab51-4f26-99fc-449229dc6a82	f
5a3f72bf-aacd-4096-b3fb-4065b7f31083	59c13612-9b23-4e7c-ad68-128ab9644df4	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
7994d91d-57f1-4bc4-85a4-890e1902b0a6	7c25dfff-9ebd-4eae-b3bb-3cd418cb3531
0f30651e-7405-4704-b7bf-a2474bb84359	f1a87ee6-0755-4e1a-a56a-d9975df85c07
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
1f55798f-e6b1-4f2e-ab76-c3d90a64e7cd	Trusted Hosts	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	anonymous
ef3d12a6-1ea4-4640-a011-5aee5144dd0b	Consent Required	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	anonymous
6420d26c-f8f6-4b9a-8d9d-0d921b7003df	Full Scope Disabled	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	anonymous
e289bd31-06b0-4003-94dd-36da055f088f	Max Clients Limit	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	anonymous
faf89fd1-1037-4394-b147-afac71e766ca	Allowed Protocol Mapper Types	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	anonymous
6d018eae-3dce-4806-8ff1-b45d4d47946c	Allowed Client Scopes	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	anonymous
cae00deb-f670-4516-8396-fdc9cfb27a8f	Allowed Protocol Mapper Types	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	authenticated
3f102e67-5463-4110-9203-b524884b794a	Allowed Client Scopes	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	authenticated
d063fb28-d8fc-4d36-b680-2e18b18ced04	rsa-generated	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	rsa-generated	org.keycloak.keys.KeyProvider	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N
72b4c057-6c86-4270-b4a4-6105593d566f	rsa-enc-generated	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	rsa-enc-generated	org.keycloak.keys.KeyProvider	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N
6faca8d6-b979-4fc5-a068-930ca2f6e9e8	hmac-generated	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	hmac-generated	org.keycloak.keys.KeyProvider	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N
e2a4bc8e-a86f-4c2e-b67b-9787ef93ee82	aes-generated	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	aes-generated	org.keycloak.keys.KeyProvider	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N
7ff7e95f-a5d6-44df-99a1-d5fea3fe9357	rsa-generated	test	rsa-generated	org.keycloak.keys.KeyProvider	test	\N
0805104b-c6bd-409b-863e-51d513a739b7	rsa-enc-generated	test	rsa-enc-generated	org.keycloak.keys.KeyProvider	test	\N
b46f24eb-9210-48b2-855e-320246d03c59	hmac-generated	test	hmac-generated	org.keycloak.keys.KeyProvider	test	\N
9fae193c-81f3-4351-adc8-f7f2cdcde23b	aes-generated	test	aes-generated	org.keycloak.keys.KeyProvider	test	\N
6b7ed20a-bf02-4b59-a958-8040ed559aa3	Trusted Hosts	test	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	anonymous
7c38a7e1-e4a2-46ba-887f-714910f3e82e	Consent Required	test	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	anonymous
88c9ac5a-5b80-4d77-a552-fa056b54fd2a	Full Scope Disabled	test	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	anonymous
66666bb0-d4e5-4851-a0e7-ba7371051a4c	Max Clients Limit	test	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	anonymous
4420023d-23a9-4f89-9d96-6fbb9dcb7b90	Allowed Protocol Mapper Types	test	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	anonymous
16fce021-8270-4d9b-9389-6873d053a17e	Allowed Client Scopes	test	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	anonymous
6bb85790-9196-4eba-b946-05cd633cdacf	Allowed Protocol Mapper Types	test	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	authenticated
7722e3c5-863d-4eca-b9e4-4674fbcaa2d4	Allowed Client Scopes	test	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	authenticated
ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	openldap	test	ldap	org.keycloak.storage.UserStorageProvider	test	\N
1718d8c3-5287-4831-8761-8a6c8e6913ea	username	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	test	\N
c7f2bd8d-b702-48f1-ad1c-4316dff50434	first name	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	test	\N
314910bd-3a2d-4da6-90d2-3571ee68eaeb	last name	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	test	\N
afdec0bc-3fc6-4e8a-a38c-0844447060ac	email	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	test	\N
1d68b0eb-abb4-437d-8f09-5e7c69241b09	creation date	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	test	\N
67f92c65-93eb-478d-b951-86f2511f97d7	modify date	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	test	\N
593f1ce5-636f-4bb4-bea2-8b764266ced2	MSAD account controls	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	msad-user-account-control-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	test	\N
20ff871b-1d24-4312-b7e4-14084d8b8594	ldap	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	ldap	org.keycloak.storage.UserStorageProvider	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N
d28e0a5d-223d-474a-9a4d-6e316c5060cb	username	20ff871b-1d24-4312-b7e4-14084d8b8594	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N
ba9be8d9-be63-4ff3-8b54-e7be1aa5273d	first name	20ff871b-1d24-4312-b7e4-14084d8b8594	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N
1bf739da-f6f2-4db3-8975-2140043ae638	last name	20ff871b-1d24-4312-b7e4-14084d8b8594	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N
083577cd-6a39-43b6-9623-910ba821cd33	email	20ff871b-1d24-4312-b7e4-14084d8b8594	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N
60932ca5-c583-496b-a0bc-f2813b8531f4	creation date	20ff871b-1d24-4312-b7e4-14084d8b8594	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N
63d797cd-7625-4e3d-a7a8-d137f6927b05	modify date	20ff871b-1d24-4312-b7e4-14084d8b8594	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N
99e7a86d-3c4f-4af1-ad13-ca824ef3c997	MSAD account controls	20ff871b-1d24-4312-b7e4-14084d8b8594	msad-user-account-control-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
86281405-625c-468d-b4ed-0e8c01115fda	faf89fd1-1037-4394-b147-afac71e766ca	allowed-protocol-mapper-types	oidc-full-name-mapper
d43215fc-b912-4d06-9b2c-1f848e4c5c9d	faf89fd1-1037-4394-b147-afac71e766ca	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
38e620ee-67db-4437-b513-1c8dd13aedc5	faf89fd1-1037-4394-b147-afac71e766ca	allowed-protocol-mapper-types	saml-role-list-mapper
844f5a93-b108-4855-8db9-4f0018e5d1c3	faf89fd1-1037-4394-b147-afac71e766ca	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
03b40753-62b1-4fdd-9256-b9454d97556e	faf89fd1-1037-4394-b147-afac71e766ca	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
25d5545a-41be-4990-bcb5-dd3eb7d644f6	faf89fd1-1037-4394-b147-afac71e766ca	allowed-protocol-mapper-types	saml-user-attribute-mapper
d87c1d5b-c18b-4573-8ed3-17d8192f8d58	faf89fd1-1037-4394-b147-afac71e766ca	allowed-protocol-mapper-types	oidc-address-mapper
087564f1-a653-4577-99c0-b91bb32bac33	faf89fd1-1037-4394-b147-afac71e766ca	allowed-protocol-mapper-types	saml-user-property-mapper
723c2ef7-f951-473c-adcd-14b84aa11434	6d018eae-3dce-4806-8ff1-b45d4d47946c	allow-default-scopes	true
d6f09d71-a8b1-4341-b53b-6d1a74c05bc9	3f102e67-5463-4110-9203-b524884b794a	allow-default-scopes	true
d6c5c72c-abbd-4c5c-9570-5c2a9f7bf97c	1f55798f-e6b1-4f2e-ab76-c3d90a64e7cd	host-sending-registration-request-must-match	true
8934bfc8-d5c6-4979-ab1a-67ae80617ac5	1f55798f-e6b1-4f2e-ab76-c3d90a64e7cd	client-uris-must-match	true
9379b5eb-f7d6-4dff-a136-226c1369143d	cae00deb-f670-4516-8396-fdc9cfb27a8f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2dd2827c-289a-4364-a1bc-6b2a802f36bb	cae00deb-f670-4516-8396-fdc9cfb27a8f	allowed-protocol-mapper-types	saml-role-list-mapper
7092abec-4e29-4c46-bd83-106b809349db	cae00deb-f670-4516-8396-fdc9cfb27a8f	allowed-protocol-mapper-types	saml-user-attribute-mapper
316bf31b-6472-4878-a345-7564261c6e3a	cae00deb-f670-4516-8396-fdc9cfb27a8f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b680175b-3822-43c0-8287-c6cc9fc7cc02	cae00deb-f670-4516-8396-fdc9cfb27a8f	allowed-protocol-mapper-types	saml-user-property-mapper
4796461a-51f1-4a69-b75d-f3df89ab5b1b	cae00deb-f670-4516-8396-fdc9cfb27a8f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
3b68b31d-ea07-4e6d-a5ce-87e40587abd3	cae00deb-f670-4516-8396-fdc9cfb27a8f	allowed-protocol-mapper-types	oidc-full-name-mapper
7d1b8db2-3a2a-4c8d-bb53-24125b1f9d9a	cae00deb-f670-4516-8396-fdc9cfb27a8f	allowed-protocol-mapper-types	oidc-address-mapper
6292e648-452d-4e73-9ae3-05072e4fa62d	e289bd31-06b0-4003-94dd-36da055f088f	max-clients	200
de1960ef-2153-4194-a4e2-00fb13a353ed	e2a4bc8e-a86f-4c2e-b67b-9787ef93ee82	secret	xmIkHa04QKbdWkzyKwQbSg
a71fb065-bce1-46fa-a0b5-d4730d23ae40	e2a4bc8e-a86f-4c2e-b67b-9787ef93ee82	priority	100
e3bf8153-a00b-4653-9299-b63d6a42723f	e2a4bc8e-a86f-4c2e-b67b-9787ef93ee82	kid	983e6083-d467-463d-8ca7-33cd2926daf1
5d9c9b7f-03bd-4c09-9f5d-a7a1caf2073d	d063fb28-d8fc-4d36-b680-2e18b18ced04	keyUse	SIG
c2b9478f-ec2a-4579-9f31-2d6d2030071c	d063fb28-d8fc-4d36-b680-2e18b18ced04	certificate	MIICmzCCAYMCBgGO8kghUjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwNDE4MTczNDU3WhcNMzQwNDE4MTczNjM3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDbzHleveU2WULp01SGIXqyfatTZQqPvHGhvowoaOZf3WXW+J7cm9V6UtQSq988rs2rjixVx04a9mzdCQHadEvWgjHX5OgFnLpNt9DlLehJK2tlO2vrwkV8OlxPqY9cq1vlh2+SQVlKhPpQjhWZW1c5nA5wac51uzCXTpKTaYquXdCyvyI6n6KZWsQGjgqXQ8yi3+Su+bumMrN08DvDJl1QPq0ZdFp7UOEWmknTb6Sve77LYW6iG87egMvvkLbtZIVAENXYEGbpjpKk+p2ICyo0dWalisIna92fl2RlF+LAw66W379AGViWD0bFH2tAgzZjX6m5h36xptgrbDF7kb1VAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHmp99XFGkSYJjQM/Ip0nuOEDrMPoAo3HSLMU6N192WtYD5O+KH0ZmK+tK+N2KkWnmeuLpP9mftsR/2NvYjsSk9alNki52sqce0FyAuJ14ulqHXugyEOYSiJtbz363tKhqYKKj9NGgm7Pr/1lGosLUOtQWdzR+nrfSLWUA9y3z5kbUSuf/XGdUT1C/Oog8M9J2zMKICV8YBhoRLck+BvJ6O23YfLaB/vAkFb3UPgySLyeLssSQuZyQuTwXaroETPO4xAYfhyXEugyMJ0yQd0WrHCqbA8DOhdDRgUowQ6dMvziRny2fQyZo+AiLTEtj/G06lfllwOe0wyizeCq9criwE=
18c47814-b987-4563-8a6e-a27b6ad116ef	d063fb28-d8fc-4d36-b680-2e18b18ced04	privateKey	MIIEpQIBAAKCAQEA28x5Xr3lNllC6dNUhiF6sn2rU2UKj7xxob6MKGjmX91l1vie3JvVelLUEqvfPK7Nq44sVcdOGvZs3QkB2nRL1oIx1+ToBZy6TbfQ5S3oSStrZTtr68JFfDpcT6mPXKtb5YdvkkFZSoT6UI4VmVtXOZwOcGnOdbswl06Sk2mKrl3Qsr8iOp+imVrEBo4Kl0PMot/krvm7pjKzdPA7wyZdUD6tGXRae1DhFppJ02+kr3u+y2FuohvO3oDL75C27WSFQBDV2BBm6Y6SpPqdiAsqNHVmpYrCJ2vdn5dkZRfiwMOult+/QBlYlg9GxR9rQIM2Y1+puYd+sabYK2wxe5G9VQIDAQABAoIBAQC4+5mZ9s+VsgHysH0OddbBqaorAXqmBb7MlYV37PEV9UrkZVGt8Sj1TghVvniepa9KltkRSC+f2Y09aXs5026QFfrE7E2pi4HwLqeMedpo2jYEeMIXJOU97BAMq3OQVld9EUMBICZ55PiWGz5qVslOHty4FxQ/WU9HyETr84NXwuWz37aRBI5ae1qexVpnPjxmRod3RemZS9wZuKTxItKNX622aziTm3B9vmZhBa/yVZooasSZYcIrgxIwFn6wU3t3sTRTPdN5u8x6Trfjv0dDPRmxckIfgv3zqCisDkhlPwX/J1UPkj311XYz5wXApJBoYgdWfMg6ycHO+lyK88UBAoGBAPCshgnHl0h+IAiY6fpXjacfpIbbaTOLPMypJuPjgvKkH+Uk5k/2EBvl6K1Q0auGjK8nQTHU8g7eYkyCbwuo1+lggXIGpYWH7nK8hNZI+4QTH4gADdh7EmFHaE7z8OEsaH9mJx4JkyJ67MC5NJembPQOirMedbOdaGmaQbDDs76RAoGBAOnLpGlWAA5dDgoxIs4KnHQZHciWoEospY/iLE2/QtvdjMR5S0P8exDIlV9lK/66vYHnDOM0GRSKvfx80POpBAq2mfjg6OP7iXumKpPmti+wZlB/OYDc1mgFgHk2TfRc8NgzY3M7NL0dN4Vj8wZckZEB9nAwX3V09gYKLOGkifyFAoGBAJ279H0kWnogb04zKeXwy93kVygrVN97OfXIRrzEt2XfOygq7ucpFZWzMLOmbERGgp2o1ImcTqiAB1ytf6ncluVVYoEg6gqB9D0uYMEwQ+djwR6ZKnne70TiT/Ku3gg12qbkhG6jR9MpTVFiEJ3zbSTnAvAx3mJBn9TWTIdVO9CBAoGBANcWj6KNCS4ttA3yWIfgQUGaHcl9seernYF63bGFRThLYgcbZAAfFwVA1BNYW5pVKKWK8FNSicRZRCI2nnGcS+ijR5ItMHUV480K+V7qQTAshGSIN1nzUZmPfjuFl0A6BSWSWWsYzBMz/vFMG7f9j7otaRCboCbKPNEfqVzJ6FyVAoGAAmE8l5WERJMyD06GtSQTEtJElfw8kWQDBRiLpOsb62CwnDPcgf82SPs56J8EOLeLgfrRh7LejmhThT9JSuRw32J+6BkTQvXDTm4wthvKWEqRztN5sww4lN44BkTKpCQqu3s4R+KkH4TpTF8VWfK1aD+6lovgNGbeCz2EnNeujM8=
2070bb52-106c-4780-9458-ed124faeb8af	d063fb28-d8fc-4d36-b680-2e18b18ced04	priority	100
2f475c83-1ec1-43e5-b4a9-95dc96ee439d	6faca8d6-b979-4fc5-a068-930ca2f6e9e8	algorithm	HS256
27bf80bc-0e3d-49ea-a175-821151220c9c	6faca8d6-b979-4fc5-a068-930ca2f6e9e8	priority	100
d4a4928b-86ac-4c51-9c4c-dd82f5cc9a08	6faca8d6-b979-4fc5-a068-930ca2f6e9e8	secret	w_W7aBDuwox4-eIw07yQrD2vCmsREHP1b8kCeWxsyg6OzDSjG4zNoa7W80XH8EP0pGj-RiLWEHiM1EVzgh7Cyw
01b9b018-4892-449b-918f-3433428c5980	6faca8d6-b979-4fc5-a068-930ca2f6e9e8	kid	ade0cb90-1293-468b-8bfb-76fdf2486867
d2bac208-59c8-42a1-9c71-c9f26932a0a6	72b4c057-6c86-4270-b4a4-6105593d566f	algorithm	RSA-OAEP
85669588-0169-4489-b79d-2aeb7b395ffa	72b4c057-6c86-4270-b4a4-6105593d566f	keyUse	ENC
1f1dcea1-41fb-4a06-8197-8e95df2d8347	60932ca5-c583-496b-a0bc-f2813b8531f4	is.mandatory.in.ldap	false
c6d53508-7f18-4393-82a7-a4ec0d6cbeed	60932ca5-c583-496b-a0bc-f2813b8531f4	always.read.value.from.ldap	true
9a0b29e7-f3c8-41d1-bc49-83e34bcb5b40	60932ca5-c583-496b-a0bc-f2813b8531f4	ldap.attribute	whenCreated
45df6aa1-ee4e-4864-99e0-290fcd291a15	60932ca5-c583-496b-a0bc-f2813b8531f4	user.model.attribute	createTimestamp
8738f5ef-6939-4dcb-8cac-f309d336c162	60932ca5-c583-496b-a0bc-f2813b8531f4	read.only	true
5ed1a499-8819-4891-b4bf-bfb28da0fb5d	72b4c057-6c86-4270-b4a4-6105593d566f	certificate	MIICmzCCAYMCBgGO8kgh7zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwNDE4MTczNDU3WhcNMzQwNDE4MTczNjM3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDBlkEuVR0OqCIRytpkYQ0amWaIuqDGM5/uWDZ8HsTEHXxH207xGTnRvPFavKCfVrhBhUhOt/Fs6OYCT3fAc4qgpHZ2GF8+bDsyH1mQnPr6irITW8JusDbiT/sHu9x93TeGInYdiIK8vs/8MUfP+l2ngYXd2ylqN9NW6uhN8/iIZJJbuAFoELLRVFrlwKJVh5RaSIJdPMxXqnKIW587yU0714gtCvwuV5vpK8k1oDO5YdMtDN3jFZrlCgnnQwRI5JAdpewYbjKT6EdCCaQ1/aHcNNfWcDkYBLerPksaA3K3zCm7Cq0fIbc5wJPrPEokw9/Ko0gBircobJxBz1TUYvbBAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAKqLRun2gzW2pGfbSvzotyeL1LYX9UeKiCoNGnoAssqdRSAoe508DTRRxDOLZPUODQFWUgsH31boqwNAqEov8cVXA81YPDyA+mWpIaJv3dkxbBXH8Vd1cnpw+6OK4BgCOsaZqFyBON0H1eDRXfZ3gZOnKxozWTZsT2Y0iHtSTrOr+mmh/tf8LrsGXBCWtn6Li0Exuh2u1+T48nC48R+vR71pRWYgqZxtBWQN8MxyLzp64LcDyISlGPGOOQcOd3SBwgS0NE1regDK7ySgIzGF7gxW1ujirWprspKDF3nQ3VYSdib9yRCchvO95UwvB1N8M1PAyBLSgT2lkBm+O02e4o8=
f9abd456-ac1f-4007-8076-4113a46a3012	72b4c057-6c86-4270-b4a4-6105593d566f	priority	100
f46a3021-6b17-4ba9-b8c1-2b5f04ad209e	72b4c057-6c86-4270-b4a4-6105593d566f	privateKey	MIIEpQIBAAKCAQEAwZZBLlUdDqgiEcraZGENGplmiLqgxjOf7lg2fB7ExB18R9tO8Rk50bzxWrygn1a4QYVITrfxbOjmAk93wHOKoKR2dhhfPmw7Mh9ZkJz6+oqyE1vCbrA24k/7B7vcfd03hiJ2HYiCvL7P/DFHz/pdp4GF3dspajfTVuroTfP4iGSSW7gBaBCy0VRa5cCiVYeUWkiCXTzMV6pyiFufO8lNO9eILQr8Lleb6SvJNaAzuWHTLQzd4xWa5QoJ50MESOSQHaXsGG4yk+hHQgmkNf2h3DTX1nA5GAS3qz5LGgNyt8wpuwqtHyG3OcCT6zxKJMPfyqNIAYq3KGycQc9U1GL2wQIDAQABAoIBAQCn8ow//xWDdriACSYpOc2diwJaktcSvQz+QcebLTJ2FkKRMKGvJ7xyyuH1X3pWYmzeYxxVNt4cJ34M+Raif1sAfU5MrF5NEKbWmD4i6R4QqK1PgCcR0oz7EHpvvjrPc1FNbK5eduU9jKlyWOq9c682uHcD/7RRc3dFi+zYXFX9NQk6NDiRTCgbArFXRfoPql8K3oKRAtdMd+0mcOaUdA/g93l2NAVDIg1CZrlkFqO58BVHaWrK7w7DPqtMRbHCpXlqnWCze1ckA2mJ0jq/jO/SzIrPmsSuQlf96l+EB196h3bpeIldXlTwFwfCR1s3Fq4zKTY3zA3iAl+BhfCAKf+1AoGBAOGuK5uQToSEjRero72CNA+w1ECUGMik/fz3ohgpGtAIiklT4sQ3fqm9PL+3Ee7T+txrOygXTao5BzfL2DDyv6UOdpIOKjH/3DxDfpqcgxLTjykr23HcLl3QVNY94TvAowlWuh2UpWdB6djgW1znHPUqGJb9iLolkMHNHp0zqUsrAoGBANuYS2QzmQV/Tn1lL+SbQkU2FoV/L1UX2naXGsS/OE0Cf06gZo73QFJ5W/VlXAa7TfFAtxX2vqlrCaO9iQKjc5Td+lHPY/Qwtboh5wj2Dnp8Rl2ZBMpvVkoBTH8ejQaas5qqzLfycPSkO0gcE+buSDDs/P7OQ7DKys8YrwiCvZ/DAoGBANH6TOasCPIxpllcwLfFmozy2TnQ0ZJ2OT+SZIYYULM5DvmVDEvG2pox0YELY6sUHrfRKbRuojt8XiPjDR7V7cw0Pcw9U7M7vX1wyy4t66KrpusGvGIfHCD7gsPnxVXkMY2x3O9C6/a8FElOzpMNEhtl9IUgFoQkCaDYKeDYPW8LAoGBAIjCRRmnZMJesZQ4o2YdJ12RPN9xARpem6jFnF8xs6+KQZzHGngpFf8HI7UlpfVvSzBXnG5qV/2M8tjt3lktUHtC73Vp0pcuis7b9FXJX+T6Zpw+AxTL2BKI0opMjYmyaO6HNq3MqHpDmcPj8KUeewk1Xq6V6OQ+t6XYepGzUsMfAoGABOUc4AwFPWYLo+LZO3W0MOQQnuD2geCYvPWSjLCTQiUpB91ekYm1zrpQx8l+3BhkvFAUCskb/g1WNNSQ76DE+05yYg7+egZuNDAIXVqe4D3giL6k9V6EesUC8w7FgFh9GMSzSfxUrg1IYIkuo77yfVK43nsvbrA5ejXGqmBy7PA=
f33cb15a-e018-4c3f-966b-e9cba66ed910	d28e0a5d-223d-474a-9a4d-6e316c5060cb	user.model.attribute	username
e61adc44-7f33-4456-9e37-329eb8042732	d28e0a5d-223d-474a-9a4d-6e316c5060cb	is.mandatory.in.ldap	true
71b65ef1-f8ae-4cfd-986e-282c1d8526b4	d28e0a5d-223d-474a-9a4d-6e316c5060cb	ldap.attribute	cn
cb4d8326-00de-4f26-8508-009f5942c3c0	d28e0a5d-223d-474a-9a4d-6e316c5060cb	read.only	true
191c3190-3249-4d75-bda0-e5b290004e76	d28e0a5d-223d-474a-9a4d-6e316c5060cb	always.read.value.from.ldap	false
a16ca43d-42ab-459a-b4bc-21569c7d6bd0	083577cd-6a39-43b6-9623-910ba821cd33	user.model.attribute	email
9042fd84-a552-4358-9e56-0c396ac4aac7	083577cd-6a39-43b6-9623-910ba821cd33	always.read.value.from.ldap	false
99930978-8eb9-4bc5-9991-5f5d1e8321e5	083577cd-6a39-43b6-9623-910ba821cd33	ldap.attribute	mail
926bac3b-fdfb-4904-9a44-18df673820f6	083577cd-6a39-43b6-9623-910ba821cd33	read.only	true
ec841d39-238b-4be2-a7b6-ccc8a225edf6	083577cd-6a39-43b6-9623-910ba821cd33	is.mandatory.in.ldap	false
18615c12-ca75-4689-934f-b072c742136c	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	priority	0
7e25c59d-6d4a-4a03-bf0e-058a809622e5	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	userObjectClasses	inetOrgPerson
e984fbed-94ba-4bad-9471-11e1855eaebd	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	cachePolicy	DEFAULT
ae39dacd-7989-4827-b79a-7fe9974a7985	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	vendor	ad
97489c62-a5d3-4418-802c-9fcfcd8fabab	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	searchScope	2
57145ca4-4ec6-4857-9051-170c88d52c01	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	fullSyncPeriod	-1
94250fd5-e052-45ae-afb6-9aee1fc6f6d9	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	bindDn	cn=admin,dc=planetexpress,dc=com
d66758a4-3fc6-4e3c-ab85-46a55ec40b3f	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	connectionPooling	true
8e94d9ac-74d3-41d2-bbb2-c39b9f929b31	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	changedSyncPeriod	-1
47fe1b1b-282c-4c67-80b6-2ad9bc0fead4	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	lastSync	1713464990
573b3cd6-87c6-4bac-99a2-aa0e85fc855d	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	validatePasswordPolicy	false
8ba56a63-c42e-4cf1-b033-7677fca55659	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	authType	simple
922398d0-23fd-41b8-8c64-cdf0cc8149ca	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	batchSizeForSync	1000
22c6baf6-4b12-456a-bde4-c0da8e6ad457	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	useKerberosForPasswordAuthentication	false
95fdcdc4-d563-4006-8d53-695221f73f97	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	importEnabled	true
4d987ae1-b3bf-4c6c-91dc-b6a6b183c139	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	syncRegistrations	false
b38aa63c-8e71-451e-bc16-843d5c2515f2	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	usersDn	ou=people,dc=planetexpress,dc=com
36f7d332-bc9f-4c1e-91f0-3f5552397df8	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	usernameLDAPAttribute	cn
55a2d390-59ad-434b-ae21-5c8ddd97fead	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	bindCredential	GoodNewsEveryone
0d8aa009-a4fd-40d3-b29e-9232d52589b6	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	editMode	READ_ONLY
23cf9f59-f0f7-43ec-b508-93a381b5f0cb	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	uuidLDAPAttribute	uid
d59634bb-21d3-49c0-9f24-1eefdd686022	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	pagination	true
9c322b21-1e96-4180-a2d4-31aab1ecb26f	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	allowKerberosAuthentication	false
5098c3ab-4b55-45ba-a2c2-93453969f96e	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	trustEmail	false
ba8871d2-4cd6-44d3-b451-3129254cc2cb	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	debug	false
69f8a696-b63d-4423-a140-732890ac5788	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	connectionUrl	ldap://openldap.openldap.svc.cluster.local:10389
19c21236-2c5e-4809-a376-c698791a8b18	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	useTruststoreSpi	ldapsOnly
669d7351-bb91-46bf-a3df-fd9cc9309be8	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	enabled	true
7c1413b7-8ce4-4200-a3b2-e74aa57ee1fb	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	rdnLDAPAttribute	cn
d55d21bc-c17d-4784-a81b-5b391fa4a709	0805104b-c6bd-409b-863e-51d513a739b7	certificate	MIIClzCCAX8CBgGO8lIGaTANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDAR0ZXN0MB4XDTI0MDQxODE3NDU0NVoXDTM0MDQxODE3NDcyNVowDzENMAsGA1UEAwwEdGVzdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKaj3JxgOfwNz1j77854HIgiEkOLNBYl3y5wmFERQaXH2u9XUjN6KepeVf6dvWGYnL4y4AsZqipYk+FwhlPjV4SEySu7snOSoMvg2jamIZXe57+2EaCR2yZg/LI46u6tuKVQfKnj4dHl57cf76BZr4Ha/zwpfZ5g0avGLUIfIPkGqS/Imnq1Px0i5uE3L+oIbL1fXet4nQi6bd0xUkcd+GXH0ie9aWhl+PWPDWhKLrSsJxgTBWTzihXQBOtGeTjuokkk9vl0nqAP2gIT0WYb3kiAmujlH2aLDumUuZZ3Sxi6weC4q9Och66/lAetsxZQQ0s1kvyvSQ9hB2iC1F4xxTUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAEHF2KjWZ5wA8rcx7gP4lsWvCKqKKOVbLSOGKuLiHdqwHoCygnPgQ2I/IzseVjdADgk9ibywjZ2IOy3mYt5+UsTL9l8qkjFHtgmgiMDNtDNhWE5PYvqKHlzQU3/6Mq7RmpI+0BLwEb2tmVO4iNasnr3s1PFPXx0Krf+TSdIltWGjQHsFNiJ1iWC0XBxUDsDxpDgzYYh8ZuhyDKZiR3QNZMeTDj1W0s14XhvA9JBYxnL+nmZElKMrN+FXNXtlc2PVjxg+zcvVUKYz+SHBu52XmCDOzu7vU/c0J0VxAa44Q0F+r4+dBoiNQkRDKbYPmVsRESw98PjY5+mHogMglmyu6Kw==
0afdf819-0d20-4135-9084-69cd889fb29d	0805104b-c6bd-409b-863e-51d513a739b7	keyUse	ENC
3d34eebd-192d-4c1d-932e-c25cfc94f64f	0805104b-c6bd-409b-863e-51d513a739b7	privateKey	MIIEowIBAAKCAQEApqPcnGA5/A3PWPvvzngciCISQ4s0FiXfLnCYURFBpcfa71dSM3op6l5V/p29YZicvjLgCxmqKliT4XCGU+NXhITJK7uyc5Kgy+DaNqYhld7nv7YRoJHbJmD8sjjq7q24pVB8qePh0eXntx/voFmvgdr/PCl9nmDRq8YtQh8g+QapL8iaerU/HSLm4Tcv6ghsvV9d63idCLpt3TFSRx34ZcfSJ71paGX49Y8NaEoutKwnGBMFZPOKFdAE60Z5OO6iSST2+XSeoA/aAhPRZhveSICa6OUfZosO6ZS5lndLGLrB4Lir05yHrr+UB62zFlBDSzWS/K9JD2EHaILUXjHFNQIDAQABAoIBAAchM6stIs35+UkhXl1DHlVkv8tMBWp9LFNcVegCCQEC0Ac1gTramzh/2MYQEa4/TVWF77gJ3RH6wDkBC35DV9c/pyvL2BLBz0dp02xLJ1y2MMwvCgoIs4us0qL9dG/J1wCbtPm/2kWUxJk9MI93xt6TdCAq1kkUc2QaEo2lr094O2hC5G4qO3/E0vD4ISETPgsJR3M92F1ZtVkzTblvdP3zgmmVW27WUBc179qANMHIBPNrCixIPo66j+1A+UAGTpG+LLwTzzTOF7DMAGrlPTaFZ1ttPbbolkjbmNtW0li5CNn9+CvHijqdbxfQLPujBzbspjKW4caQoeIKL4cMQnECgYEA/9e/nNR1gxtrLxz8ACAJ37PUny1MsapUoyeMNEgl9QynqTW/KrPoUeBbjyKDMpg+XtiLAU9WMpf2HZUZvrUfiArqAkxSotze7E9ktyrJcF+9VQVxcIUZf6ozvl7HyMrV08cIORl9LJI8+HlYqAbdPZlJ7Ge9fbEIhy8pIAKAmOcCgYEApr4UP6cZ97cwWWIUSOCaNBZitku/fj/lumAhYX03sz4OO3hnsVuW8udd8Ocv3ONjTrC961AwnsxD7qhCxtcdBFO1byzmhb/JKybX5KYsEv+H8LkI8VT/4DA78LlbudrqQ6TvbdHi6m9wjqkO2oHA6cMY1QfhsU7Jq3Affu1sYYMCgYEAl1uYbLv02Z+7BaBsJdbOgJ3vSEyQdvuCHxQiiju02QinmB/H/Qd6hhXplQCiBai0HYCWnCvHnx7v6AhxtrWI9f8e+kUVDm0FJWDDAOo7SlQZutcBicP0leanvhRstYnqfuPdJYrC1z+c+pMvtBh7gxnQ9h9Zp6a4mOF5vwo78jkCgYB3if3qRFoRhXtcGTyBosPqY8IQ/u0iDZ0cqJ5FzgeIsQxzBjcQp6DoM4bdlmBx83LWj08YzDyPG9H33xlAhCeBWqHQOlhpurz1+rr8aUVfuWIz6fPHUDDBANN4GOrxq0gXhr8/9CDCAXKoU/saG7u52uyKjUP4YYujJJbv4Da7EQKBgF0jXQEiakA+JRQYTMpdR8GCDXB8vGljqSlHgRCc4oqmLFzS7GtK/GLurJ26emLLQ/ilAYrXIHcJrv2FgLYAIH4mHqnAb+Fr/oUggI5jIVu/M5zB8dm+X/p5sJ/cBYCQ9z18wKISa7cowBU7xTDBNB0XZYvLergFsdkTrqp8RLQq
b37b8fc4-abdc-4855-a650-256fddb72976	0805104b-c6bd-409b-863e-51d513a739b7	priority	100
6af5c332-0ab1-4401-900d-89010cca6792	0805104b-c6bd-409b-863e-51d513a739b7	algorithm	RSA-OAEP
78e4447b-4c84-4ca2-b63e-68b2ca22880c	9fae193c-81f3-4351-adc8-f7f2cdcde23b	priority	100
9a92ce79-78b5-4d1a-8835-a96a2478e8d0	9fae193c-81f3-4351-adc8-f7f2cdcde23b	kid	52553c40-7852-4a9f-b3c0-aabc065608e0
a5ad047b-2ea4-4b50-a305-1180ef27e37c	9fae193c-81f3-4351-adc8-f7f2cdcde23b	secret	r4aBN9QcSN8LxoQUCFNLpg
157e9eac-4255-4d8c-8548-c2066dcdb72c	7ff7e95f-a5d6-44df-99a1-d5fea3fe9357	certificate	MIIClzCCAX8CBgGO8lIGFDANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDAR0ZXN0MB4XDTI0MDQxODE3NDU0NVoXDTM0MDQxODE3NDcyNVowDzENMAsGA1UEAwwEdGVzdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ5d4NDRXtkzZz8cvnbluPDF+R+4mpgDINzIzmWkIsXHQ5tT8AYQE5djSB0F6l1XbGLzJGxAMLmOixk/77GtvCKieh/JmK1fehGr9clhPVEaS0RrwrSrfv0EeRrWX1Dg0ardaNi5FfpqunQ3qXCp1vPhsez/kDEQcv2sEjY7lx0rcIxS+g+EGJpQyHaQwYvbU3yxd4XTE38YlEbEZ4KAQ+4HbGYzGQPZNclJakauexxPECzc0HLKjrO0bH+/1Lu46moal86/bP+rF10FccxphhlVi8OmMA9XV8Mdv5a48AQv3WdFHSb+lb7KR4HODIph0eRgpmcC2LtvhNnLY31tIb8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAcVCCvKNXwlwF2nrohlTBP7GByMy9wmMGYF7n9wL/gumFjNrwxfq6csqL9DiZxWgX5tIoZM7NsURBJp2jv5btRJhs82MlTduLMghuSlaYp79dsqdKtcmjFumRf9XhAbmGif8Z6TEDeAl4A21uCsAdCJMVKm6Zxo5R2sIC3NknQORKjedDNnlgFlbZ8s93Q0npHD4VfxAMq0npZQk9DtK/VIZ2GxNSaRXXeFYdlOEPwW6dS1IsKW4OvSOPCt5EcnrMGeAShDYmOYAanhlPp8kO07YFFVqtMM3KKo8mQZfW6Jvk3ZVMdpeak84yEJllhW1aNNmmGCJmQQQme5poipLQ0Q==
4a5c5a3f-468f-4991-8481-4e7963c843df	7ff7e95f-a5d6-44df-99a1-d5fea3fe9357	priority	100
3c03440d-977f-46f4-8835-f016b1bf82be	7ff7e95f-a5d6-44df-99a1-d5fea3fe9357	privateKey	MIIEpQIBAAKCAQEAnl3g0NFe2TNnPxy+duW48MX5H7iamAMg3MjOZaQixcdDm1PwBhATl2NIHQXqXVdsYvMkbEAwuY6LGT/vsa28IqJ6H8mYrV96Eav1yWE9URpLRGvCtKt+/QR5GtZfUODRqt1o2LkV+mq6dDepcKnW8+Gx7P+QMRBy/awSNjuXHStwjFL6D4QYmlDIdpDBi9tTfLF3hdMTfxiURsRngoBD7gdsZjMZA9k1yUlqRq57HE8QLNzQcsqOs7Rsf7/Uu7jqahqXzr9s/6sXXQVxzGmGGVWLw6YwD1dXwx2/lrjwBC/dZ0UdJv6VvspHgc4MimHR5GCmZwLYu2+E2ctjfW0hvwIDAQABAoIBAEzeADsbBNCkFJ8bko8fXa7wSMVO0yqpig/gH95R1tbsqzH/gedPclLuy5fawTDhOCinH6yzU3MdbwKod+1kCIc/GcvIDCVKzHM7ZieC3UI6YwIo0+7htteUjjuqhcU5+krXAQcAf1x25V13jvSyWzUw/S2ttg06kLX0CTrtnaF4KLEj07Ajf91hrnKxFxV3Fl6b2dOPs5EbJYmD7aE4PkH0NEzHvTgVsfXQ9mtBN5nIdu2Tkk/M1XzmJNygxPRNKpvqW4LkpDWFUyUPEPVSg7hvVinGHrXyWq1uf8/IWxcB8JMZWaZYbiYU2SOrgYPq06bPSTTF7Jk8yo2kvDcE9XECgYEA6Qav7UzZdiPj0pSvELfopfMjm1pxy/ZmRzPFBzZS1dVcohO1wk8mu/BOdu1dNvxl04dTSIC0FH9KM/6IkRquKg94zKyO0rgvEKIG2+wFuQDn550G1uDXpPJJMbv3kpi+PZu+lXhBT5/Y6i3jY57jVMivUZVpv5k/fvHQ7IShY/sCgYEArfrfcykjML2F/Y6THS3GpEjpnguYVVJFicPoguCxOYrxJFpYC5bZP/SsXsC8AUmttbN40yITWC5NM8xzFCN2ofT28ZNno//pRxPS/58LzF0NIJvkeZTbqd5K9Y5VDQLpM5eeLzlKEu7PHpVGijbVro6CzIVgXcmy9lJ47cJVyg0CgYEApl5V4HBLmeNJ1qC81IzZFxIeS94o/NvwbclyVBHe1jg8qKK11AK6vtd0zcfuE0HkWT92oH7zEudGTRTe3+pSikj9j/NrDNrfD1r+1qkN9OXGrEAaD/P7QhKRW2a9/PX8bPPy/7gZuQWA0sDsZcWcvH2DXhX0qAx7nuB6r0KKD10CgYEAkB6+lXYhaZHF+hnuMgCmiZbAt6RhR2SEqC+6XxhklwdK5NNWFhua0ckMNN2xn9t544fNchDLN4P7fgpB1g/eiSEUo195PjiS9McuRYRp0JvQcQ/SfwjZwmibbbi/Ka0coxlY90Oc4fwjZPFBYuMztYrmPSfLgUXBUx1UgZg3Ws0CgYEAuufou/PTBVr8j4PrmxIj2x2xldyki1stfHha6KiBwxi1QqA3tMwh/uemN3ggBjrkQI+aeGVW2lYgBD5I36m3i0sJioYqi/nH6TfaSbBSTZskoed4vcenBtZny78JwgkJsga9wvnCHGl2qaH4dKGnyMkSnx2bhxbTPJJOHg7B+ZA=
7567b3e1-7175-4aa5-b2cf-577399a296d7	7ff7e95f-a5d6-44df-99a1-d5fea3fe9357	keyUse	SIG
42ebe9f9-09d2-42a6-b4c7-e621d424ea5f	b46f24eb-9210-48b2-855e-320246d03c59	kid	239779a2-f7b9-4378-a0b6-2b389c831433
5bbdb7ef-f2b2-4267-943e-88c7457b073a	b46f24eb-9210-48b2-855e-320246d03c59	algorithm	HS256
ee045fed-bbf1-4f02-87d2-d47ece652434	b46f24eb-9210-48b2-855e-320246d03c59	priority	100
6ce76ac4-a901-42f8-9bce-c29e6c91c5f2	b46f24eb-9210-48b2-855e-320246d03c59	secret	qteXSVpxGv4kMYOX1s0q_fzidzTrc6KDxP7GOMzIo1-n2lErL26NaYLO2f8ZI-xaRiSeH1D6RFhASUSrPomeug
2de2d60b-3c28-42a1-8925-c8ce7c7761cf	16fce021-8270-4d9b-9389-6873d053a17e	allow-default-scopes	true
159ac9e3-1baa-4244-aa3d-1faa6e1282b4	66666bb0-d4e5-4851-a0e7-ba7371051a4c	max-clients	200
0565b6a6-4db3-4c66-8789-a47434abb46d	4420023d-23a9-4f89-9d96-6fbb9dcb7b90	allowed-protocol-mapper-types	oidc-full-name-mapper
77d3980d-9894-48b8-b07e-9e93697b79bf	4420023d-23a9-4f89-9d96-6fbb9dcb7b90	allowed-protocol-mapper-types	saml-user-attribute-mapper
330995cc-a02f-4f61-8504-69468f84f09f	4420023d-23a9-4f89-9d96-6fbb9dcb7b90	allowed-protocol-mapper-types	oidc-address-mapper
5b288319-adb8-4151-801d-5e9fd6709fb7	4420023d-23a9-4f89-9d96-6fbb9dcb7b90	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
59944076-8ae9-4a9c-9573-e0d37be74040	4420023d-23a9-4f89-9d96-6fbb9dcb7b90	allowed-protocol-mapper-types	saml-role-list-mapper
3eba24aa-6211-4390-824c-4ed7cd5bd907	4420023d-23a9-4f89-9d96-6fbb9dcb7b90	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
1e6d7618-5e8d-454f-a37e-2102b5a212d2	4420023d-23a9-4f89-9d96-6fbb9dcb7b90	allowed-protocol-mapper-types	saml-user-property-mapper
e52ca0bd-d313-4f45-9214-662a06a2648a	4420023d-23a9-4f89-9d96-6fbb9dcb7b90	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
644b4da6-d3e3-4c70-8b7f-3373b056ea15	6bb85790-9196-4eba-b946-05cd633cdacf	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a456f55d-ff49-478e-aab8-d9ecf7ed58e5	6bb85790-9196-4eba-b946-05cd633cdacf	allowed-protocol-mapper-types	saml-role-list-mapper
7278b1f5-5ce4-41a6-9ccf-a82c20682c7f	6bb85790-9196-4eba-b946-05cd633cdacf	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
1f1ac8e6-8003-475a-ad19-35b6438b71d9	6bb85790-9196-4eba-b946-05cd633cdacf	allowed-protocol-mapper-types	saml-user-attribute-mapper
4987b26b-9450-4ee0-b822-2a1c170720b2	6bb85790-9196-4eba-b946-05cd633cdacf	allowed-protocol-mapper-types	saml-user-property-mapper
d7c89b67-b7e2-4699-a7ea-91f767a315f5	6bb85790-9196-4eba-b946-05cd633cdacf	allowed-protocol-mapper-types	oidc-full-name-mapper
17c7095a-e3e2-4c3f-8993-69e718f9dca5	6bb85790-9196-4eba-b946-05cd633cdacf	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
685db5d4-7658-48ff-b07e-5a123075756b	6bb85790-9196-4eba-b946-05cd633cdacf	allowed-protocol-mapper-types	oidc-address-mapper
d78a1053-b142-432e-93e9-f1fef3c50272	6b7ed20a-bf02-4b59-a958-8040ed559aa3	host-sending-registration-request-must-match	true
1ec3c296-34b7-4a4f-8466-4ace0c3bb4ca	6b7ed20a-bf02-4b59-a958-8040ed559aa3	client-uris-must-match	true
46c1d9db-fcf9-44c4-aa88-6098f1050b6f	7722e3c5-863d-4eca-b9e4-4674fbcaa2d4	allow-default-scopes	true
146b4439-0363-4dcd-b32a-f835b5de4b2c	63d797cd-7625-4e3d-a7a8-d137f6927b05	always.read.value.from.ldap	true
562ee0c1-fb45-4e14-95ad-42a2387a043d	63d797cd-7625-4e3d-a7a8-d137f6927b05	is.mandatory.in.ldap	false
f4bd1938-cf81-45fe-a166-3ca7eb410704	63d797cd-7625-4e3d-a7a8-d137f6927b05	ldap.attribute	whenChanged
b3f4544d-539b-4a08-bf15-4e18b0b4c870	63d797cd-7625-4e3d-a7a8-d137f6927b05	user.model.attribute	modifyTimestamp
d65514a0-5ab0-48a0-b6e7-e13411760094	63d797cd-7625-4e3d-a7a8-d137f6927b05	read.only	true
259a6933-f4ea-46cd-a479-136ae36028e5	ba9be8d9-be63-4ff3-8b54-e7be1aa5273d	user.model.attribute	firstName
3a71d893-3600-4ddd-884f-f08101b30de3	ba9be8d9-be63-4ff3-8b54-e7be1aa5273d	always.read.value.from.ldap	true
d670edef-d67c-49fa-93be-c32fa81ba84a	ba9be8d9-be63-4ff3-8b54-e7be1aa5273d	is.mandatory.in.ldap	true
03e87550-e906-4ebc-a2b8-527d4bd16685	ba9be8d9-be63-4ff3-8b54-e7be1aa5273d	ldap.attribute	givenName
d698b4bb-822a-4d81-90bf-a0f359b26bc5	ba9be8d9-be63-4ff3-8b54-e7be1aa5273d	read.only	true
c2a5d3c6-9140-4405-9afe-0730e3f66743	1bf739da-f6f2-4db3-8975-2140043ae638	always.read.value.from.ldap	true
ba84e0fb-8a3b-4ff1-bf68-3d3b53e47983	1bf739da-f6f2-4db3-8975-2140043ae638	user.model.attribute	lastName
4fe22267-1c62-4ebb-8070-a8c94b7f2272	1bf739da-f6f2-4db3-8975-2140043ae638	is.mandatory.in.ldap	true
760b697e-a58a-43ee-be83-66aa9d1cacfc	1bf739da-f6f2-4db3-8975-2140043ae638	ldap.attribute	sn
064d5a7f-442c-4d05-8f08-1440c8cee03c	1bf739da-f6f2-4db3-8975-2140043ae638	read.only	true
9632e095-8e70-40fe-ae6e-a89ab17b13c1	c7f2bd8d-b702-48f1-ad1c-4316dff50434	always.read.value.from.ldap	true
7bdc0602-5b0c-4369-82c9-dce2ce34c6df	c7f2bd8d-b702-48f1-ad1c-4316dff50434	is.mandatory.in.ldap	true
d4cd2b59-2604-4567-a576-7e7c3790ce33	c7f2bd8d-b702-48f1-ad1c-4316dff50434	user.model.attribute	firstName
4939948c-bf92-48b8-a7f2-c30bd5e345c8	c7f2bd8d-b702-48f1-ad1c-4316dff50434	ldap.attribute	givenName
ef5f1ab5-421d-4f11-a4bf-e2bae0df01f7	c7f2bd8d-b702-48f1-ad1c-4316dff50434	read.only	true
b6c86e93-b741-4423-a27c-0cab729401b4	1718d8c3-5287-4831-8761-8a6c8e6913ea	user.model.attribute	username
c661e896-1ac3-416b-b36b-bbc31a4c6ad4	1718d8c3-5287-4831-8761-8a6c8e6913ea	is.mandatory.in.ldap	true
fd40d530-e60a-488f-b34f-bca908d8c656	1718d8c3-5287-4831-8761-8a6c8e6913ea	read.only	true
3260d6bc-a304-4e5d-b05c-ea96548cf76c	1718d8c3-5287-4831-8761-8a6c8e6913ea	always.read.value.from.ldap	false
1ac93cfb-dfb8-423a-94d4-5cc842af00c6	1718d8c3-5287-4831-8761-8a6c8e6913ea	ldap.attribute	cn
b5eb0915-a0e0-4727-9f8f-b6f85456a039	67f92c65-93eb-478d-b951-86f2511f97d7	ldap.attribute	whenChanged
1b4a19ad-df63-47df-8477-0696268491dd	67f92c65-93eb-478d-b951-86f2511f97d7	is.mandatory.in.ldap	false
73e80d0a-2219-4090-8903-974b1123fa1b	67f92c65-93eb-478d-b951-86f2511f97d7	always.read.value.from.ldap	true
cb90b812-3d7d-4432-b607-f378fa974f43	67f92c65-93eb-478d-b951-86f2511f97d7	user.model.attribute	modifyTimestamp
7496c190-5c00-43e0-aeee-d74ffc255d16	67f92c65-93eb-478d-b951-86f2511f97d7	read.only	true
4c46e451-ec9b-47dc-8896-6cf6a4272344	afdec0bc-3fc6-4e8a-a38c-0844447060ac	always.read.value.from.ldap	false
ede9cc2d-8228-4abf-bf43-2e0fe6ef914d	afdec0bc-3fc6-4e8a-a38c-0844447060ac	ldap.attribute	mail
4da4972a-cd1d-4510-84de-f67dd7a891e6	afdec0bc-3fc6-4e8a-a38c-0844447060ac	is.mandatory.in.ldap	false
7dd84761-d6bc-48c1-b340-d6abc9b45b5a	afdec0bc-3fc6-4e8a-a38c-0844447060ac	read.only	true
22307688-5e52-4bc3-9dd3-9ca6768540b8	afdec0bc-3fc6-4e8a-a38c-0844447060ac	user.model.attribute	email
eddcdd85-28fd-4dff-8501-b612d0a835d4	314910bd-3a2d-4da6-90d2-3571ee68eaeb	ldap.attribute	sn
146c639b-87a2-4097-b49a-1c0d9a3e4524	314910bd-3a2d-4da6-90d2-3571ee68eaeb	always.read.value.from.ldap	true
a17e8408-cfa6-4984-b227-a49b91d08721	314910bd-3a2d-4da6-90d2-3571ee68eaeb	is.mandatory.in.ldap	true
5823edae-1048-4a69-9df0-62df9161e37f	314910bd-3a2d-4da6-90d2-3571ee68eaeb	user.model.attribute	lastName
e4cd9264-26fc-4b1e-b04b-8f92cd77807c	314910bd-3a2d-4da6-90d2-3571ee68eaeb	read.only	true
637336ba-4e0f-401a-a96e-8674d85cc3c8	1d68b0eb-abb4-437d-8f09-5e7c69241b09	read.only	true
4624c3aa-1b99-4605-b755-1a86ce83e6ad	1d68b0eb-abb4-437d-8f09-5e7c69241b09	user.model.attribute	createTimestamp
0ca0cb25-ca2b-4a64-8916-f7c5439332b7	1d68b0eb-abb4-437d-8f09-5e7c69241b09	always.read.value.from.ldap	true
a3a2401b-4f24-4e94-b4e0-e2736c4841cd	1d68b0eb-abb4-437d-8f09-5e7c69241b09	ldap.attribute	whenCreated
45e1c454-439a-4e18-9fab-4d4387cf9327	1d68b0eb-abb4-437d-8f09-5e7c69241b09	is.mandatory.in.ldap	false
79c6f0aa-f627-4a31-ac38-b76dcb519227	20ff871b-1d24-4312-b7e4-14084d8b8594	lastSync	1713465028
61d84064-a3df-445d-ad16-730d99c00f6e	20ff871b-1d24-4312-b7e4-14084d8b8594	syncRegistrations	false
1224d9da-78f7-4142-80f7-d77b558d5747	20ff871b-1d24-4312-b7e4-14084d8b8594	usernameLDAPAttribute	cn
51983e51-af79-4724-a3b3-d1285e55570f	20ff871b-1d24-4312-b7e4-14084d8b8594	rdnLDAPAttribute	cn
07f82dc0-15fc-4b42-a912-c023793028ff	20ff871b-1d24-4312-b7e4-14084d8b8594	connectionPooling	true
b408e5c6-2b5f-42a5-887f-4be29e5e8a5d	20ff871b-1d24-4312-b7e4-14084d8b8594	batchSizeForSync	1000
bfa2bd2e-12ed-4de1-af77-b50e6988a7d7	20ff871b-1d24-4312-b7e4-14084d8b8594	useTruststoreSpi	ldapsOnly
a08e6d3e-1254-4167-be32-cc73d2dc3d2b	20ff871b-1d24-4312-b7e4-14084d8b8594	bindDn	cn=admin,dc=planetexpress,dc=com
6c74b4a0-85e8-422d-97f9-5db0b7fdc4a5	20ff871b-1d24-4312-b7e4-14084d8b8594	editMode	READ_ONLY
23c1d33c-9f73-4aca-90fc-c4cc58db90bb	20ff871b-1d24-4312-b7e4-14084d8b8594	usersDn	ou=people,dc=planetexpress,dc=com
53bf3a53-7376-4fd6-92f0-986966df2aaa	20ff871b-1d24-4312-b7e4-14084d8b8594	vendor	ad
53a2672d-6835-4a80-b9c0-05fae74111c8	20ff871b-1d24-4312-b7e4-14084d8b8594	userObjectClasses	inetOrgPerson
b8644614-3fe4-4312-8b50-519d3a155c4f	20ff871b-1d24-4312-b7e4-14084d8b8594	allowKerberosAuthentication	false
91b6be74-87eb-4d79-b437-fe8b51ed6e78	20ff871b-1d24-4312-b7e4-14084d8b8594	uuidLDAPAttribute	UID
a8403e04-2344-479a-9eaf-0d35e15b75d8	20ff871b-1d24-4312-b7e4-14084d8b8594	connectionUrl	ldap://openldap.openldap.svc.cluster.local:10389
aac61242-36d8-4f9f-a666-3b1235361d56	20ff871b-1d24-4312-b7e4-14084d8b8594	changedSyncPeriod	-1
0f62c0c3-5500-45a4-9411-b5893a044aef	20ff871b-1d24-4312-b7e4-14084d8b8594	bindCredential	GoodNewsEveryone
e5e06617-4af6-4a93-942b-1bcca1367e3e	20ff871b-1d24-4312-b7e4-14084d8b8594	debug	false
a090edae-a6c6-4b13-8de6-fbd28be45a60	20ff871b-1d24-4312-b7e4-14084d8b8594	useKerberosForPasswordAuthentication	false
7b793af7-428a-46af-9c84-68d3654439c3	20ff871b-1d24-4312-b7e4-14084d8b8594	enabled	true
7caa8177-58af-41ce-9c54-b2fb3e820ad5	20ff871b-1d24-4312-b7e4-14084d8b8594	cachePolicy	DEFAULT
a85fff5f-3bf9-4be0-91fe-ebbd52e406eb	20ff871b-1d24-4312-b7e4-14084d8b8594	importEnabled	true
4b0be757-fa79-4569-a32f-cc4814201e0b	20ff871b-1d24-4312-b7e4-14084d8b8594	searchScope	1
6200849c-85ba-4849-a5b5-7d9c6b9f082f	20ff871b-1d24-4312-b7e4-14084d8b8594	validatePasswordPolicy	false
0fa5a648-fef8-46f0-b530-f68db652400b	20ff871b-1d24-4312-b7e4-14084d8b8594	authType	simple
71cf5f98-0190-4e01-9e17-4d8843d853a0	20ff871b-1d24-4312-b7e4-14084d8b8594	priority	0
a62dfa4f-8b3f-4bb4-8951-5e0bd3729677	20ff871b-1d24-4312-b7e4-14084d8b8594	pagination	true
7084a7aa-2d3c-47a1-8483-785101f5d68a	20ff871b-1d24-4312-b7e4-14084d8b8594	fullSyncPeriod	-1
7f1886b3-3c0e-4ab7-99b2-0193684e93ce	20ff871b-1d24-4312-b7e4-14084d8b8594	trustEmail	false
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
692ff45c-c18a-4f35-b9cd-076ed09f5133	fd43e617-7e85-478e-b743-0591cb8504a7
692ff45c-c18a-4f35-b9cd-076ed09f5133	4398a377-de49-49d8-8d97-912d0086f428
692ff45c-c18a-4f35-b9cd-076ed09f5133	c40e92d5-961c-4f0c-8b80-ae98faeb3018
692ff45c-c18a-4f35-b9cd-076ed09f5133	cd35990a-9e76-444a-a0bd-b31bb50fe658
692ff45c-c18a-4f35-b9cd-076ed09f5133	62c298ee-f6fc-455e-aaee-7a60129590e0
692ff45c-c18a-4f35-b9cd-076ed09f5133	39a4fba2-1d3a-459f-b465-49666408cbde
692ff45c-c18a-4f35-b9cd-076ed09f5133	6071c19e-f4b6-4836-8c4e-8a64d9a007f9
692ff45c-c18a-4f35-b9cd-076ed09f5133	811ea7b4-8272-4fc3-a73e-fe17ec69ff3d
692ff45c-c18a-4f35-b9cd-076ed09f5133	23ef7816-9589-4f6f-bfa3-33dad88dff00
692ff45c-c18a-4f35-b9cd-076ed09f5133	b5807e22-5c9f-4810-9e2e-ada1a1921859
692ff45c-c18a-4f35-b9cd-076ed09f5133	6c6badf2-4a97-4608-a53a-4473edcf96ca
692ff45c-c18a-4f35-b9cd-076ed09f5133	d8d9fd0e-1a8c-4759-bc38-164148d8eeb6
692ff45c-c18a-4f35-b9cd-076ed09f5133	2fa92d11-26c0-4bbc-a175-465d8d299b75
692ff45c-c18a-4f35-b9cd-076ed09f5133	2bd49ab8-0e09-4b23-afb3-4abb95d2e815
692ff45c-c18a-4f35-b9cd-076ed09f5133	0d247991-54f5-459e-bf4f-9cd2afe0f047
692ff45c-c18a-4f35-b9cd-076ed09f5133	bdaa4862-260e-4b1e-a6b1-bbef9d1bc71d
692ff45c-c18a-4f35-b9cd-076ed09f5133	ef00b9d7-f31a-4d89-866c-a17c08452214
692ff45c-c18a-4f35-b9cd-076ed09f5133	f1671e39-5a49-450d-a56f-9d699da7ef9f
62c298ee-f6fc-455e-aaee-7a60129590e0	bdaa4862-260e-4b1e-a6b1-bbef9d1bc71d
cd35990a-9e76-444a-a0bd-b31bb50fe658	0d247991-54f5-459e-bf4f-9cd2afe0f047
cd35990a-9e76-444a-a0bd-b31bb50fe658	f1671e39-5a49-450d-a56f-9d699da7ef9f
d1d03d49-5085-4e4d-9bba-80da7ec478e2	90424b37-6fd0-4695-8128-296e232d0abf
d1d03d49-5085-4e4d-9bba-80da7ec478e2	9fe6195e-9708-4aec-a1af-1d3ea5a0e329
9fe6195e-9708-4aec-a1af-1d3ea5a0e329	db5496cb-33c7-43cd-bd1f-c60731a126a9
e8eb1c80-4560-404b-8438-15bf2b210253	651c5774-00d7-4cc0-819d-3e6fdd3721f2
692ff45c-c18a-4f35-b9cd-076ed09f5133	f0d1ebf0-38c6-4c0d-a70b-8e6b218fbfb4
d1d03d49-5085-4e4d-9bba-80da7ec478e2	7c25dfff-9ebd-4eae-b3bb-3cd418cb3531
d1d03d49-5085-4e4d-9bba-80da7ec478e2	93573320-e370-4d8b-bfed-820fc20f8249
692ff45c-c18a-4f35-b9cd-076ed09f5133	05e60180-0ff5-4bf4-9eef-5b6cc6b970bc
692ff45c-c18a-4f35-b9cd-076ed09f5133	d4194e70-2276-430d-9d56-4395535e0d13
692ff45c-c18a-4f35-b9cd-076ed09f5133	376ba33f-7934-41d0-a53d-f08d218a07db
692ff45c-c18a-4f35-b9cd-076ed09f5133	e0b5492f-c5c0-4ce8-87c3-40426f88dc4f
692ff45c-c18a-4f35-b9cd-076ed09f5133	371c369f-a6e5-44a5-9f48-f9e580771107
692ff45c-c18a-4f35-b9cd-076ed09f5133	61c937b9-8c11-4e5d-b287-4d36f50bc147
692ff45c-c18a-4f35-b9cd-076ed09f5133	10daa0cb-9513-43a4-8fab-b69284909058
692ff45c-c18a-4f35-b9cd-076ed09f5133	3723d33d-9647-478d-a60e-78228cdeb91d
692ff45c-c18a-4f35-b9cd-076ed09f5133	cf20a14f-7f36-47e1-9082-f02d646c1725
692ff45c-c18a-4f35-b9cd-076ed09f5133	fd0a3875-df3d-4808-9876-85def46e4720
692ff45c-c18a-4f35-b9cd-076ed09f5133	3c45d12c-0daf-4690-af59-6153fe38b68a
692ff45c-c18a-4f35-b9cd-076ed09f5133	d5d2450d-382b-4af6-9909-bffdc43009c1
692ff45c-c18a-4f35-b9cd-076ed09f5133	ab18ae86-8b38-49ed-9da0-0d0d36c9998d
692ff45c-c18a-4f35-b9cd-076ed09f5133	bebb48d8-c24c-4620-9763-391d1716fcec
692ff45c-c18a-4f35-b9cd-076ed09f5133	7e9a9599-3433-44ec-974f-9bb087ce76fb
692ff45c-c18a-4f35-b9cd-076ed09f5133	89e1ada2-0640-426e-bfa7-9278723991a4
692ff45c-c18a-4f35-b9cd-076ed09f5133	efb7bdce-616e-48a6-bb0d-1ef1a5a66ceb
e0b5492f-c5c0-4ce8-87c3-40426f88dc4f	7e9a9599-3433-44ec-974f-9bb087ce76fb
376ba33f-7934-41d0-a53d-f08d218a07db	bebb48d8-c24c-4620-9763-391d1716fcec
376ba33f-7934-41d0-a53d-f08d218a07db	efb7bdce-616e-48a6-bb0d-1ef1a5a66ceb
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	042c036f-3734-4123-aa73-a91f9358e93d
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	f9899486-64eb-4965-b026-b2edc84d83ee
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	8353376d-8a19-4b57-b350-d2bd55cdeba7
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	ba8db325-6452-42f2-b432-19c4e5fdaae0
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	b0c7f1ef-aee8-4b5e-a427-03cb21f438d1
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	c1b15caf-2fac-44f1-9013-982659c36c67
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	1cf2eb81-1815-4507-a760-cddd18651ada
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	6e90c055-947f-451c-910f-64a3aa50e9c4
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	ecd3f533-cf2d-463c-8a95-23ae872858f0
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	6960bd5f-757a-4e19-b893-b2de1905bc6d
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	e2f64c12-2c29-4d27-b8a7-7a5db64eaf66
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	dc232760-9c16-4d35-b2f9-54e356ff963b
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	37a4a476-3b89-40f0-9a12-c1cad2f13c6f
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	c96a0478-ab84-48d2-8027-3ab9e8c91d09
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	11bf4e9e-0cab-4cc9-a7f5-edd115cf1e68
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	7097b1b9-fec8-4b6f-8acc-5b22d2a61021
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	2a801268-f904-4ee5-954e-7a745fdb4487
ba8db325-6452-42f2-b432-19c4e5fdaae0	11bf4e9e-0cab-4cc9-a7f5-edd115cf1e68
8353376d-8a19-4b57-b350-d2bd55cdeba7	c96a0478-ab84-48d2-8027-3ab9e8c91d09
8353376d-8a19-4b57-b350-d2bd55cdeba7	2a801268-f904-4ee5-954e-7a745fdb4487
450c5b8b-dfb6-432a-a184-9b472ef77f86	0a47f304-8cdf-4084-a840-d700ac803fd5
450c5b8b-dfb6-432a-a184-9b472ef77f86	6028ea4a-d6cc-40f4-ad4c-ba06a65c7293
6028ea4a-d6cc-40f4-ad4c-ba06a65c7293	169d607a-a1b2-47c6-a24b-83995664d970
504c3bc8-4181-47a1-9c7c-c8ea22a9ffd1	3359228f-112e-43f4-8e51-cf4bf82f4d8c
692ff45c-c18a-4f35-b9cd-076ed09f5133	4256d2e6-9c73-4ae6-8cc5-6226ab57e7b6
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	488d99ac-a949-472c-bf24-9b0e32e85fb8
450c5b8b-dfb6-432a-a184-9b472ef77f86	f1a87ee6-0755-4e1a-a56a-d9975df85c07
450c5b8b-dfb6-432a-a184-9b472ef77f86	cd6d260c-d103-4482-ab3a-37c8b85bad35
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
79ae4c44-4350-40d0-997e-fc5f3c048e85	\N	password	636228eb-9869-4c9a-a74d-1848b4741a7d	1713461798191	\N	{"value":"k2he6jb7189S6sEjo27cFlbujVP5q3/7jFjKD5FrEFSHEoqsYeMJxgK2KWFd4d0oLBFHfrSEZ3Uoh/fUMel3Pw==","salt":"YnM/0ta2XP6A4FBEEhPBNg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-04-18 17:36:25.792938	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	DEV	\N	\N	3461785316
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-04-18 17:36:25.80198	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	DEV	\N	\N	3461785316
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-04-18 17:36:25.886706	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	DEV	\N	\N	3461785316
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-04-18 17:36:25.893765	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	DEV	\N	\N	3461785316
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-04-18 17:36:26.24777	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	DEV	\N	\N	3461785316
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-04-18 17:36:26.251955	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	DEV	\N	\N	3461785316
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-04-18 17:36:26.406895	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	DEV	\N	\N	3461785316
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-04-18 17:36:26.410129	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	DEV	\N	\N	3461785316
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-04-18 17:36:26.422774	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	DEV	\N	\N	3461785316
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-04-18 17:36:26.647893	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	DEV	\N	\N	3461785316
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-04-18 17:36:26.768982	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	DEV	\N	\N	3461785316
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-04-18 17:36:26.771992	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	DEV	\N	\N	3461785316
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-04-18 17:36:26.906285	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	DEV	\N	\N	3461785316
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-04-18 17:36:27.097869	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	DEV	\N	\N	3461785316
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-04-18 17:36:27.117897	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	DEV	\N	\N	3461785316
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-04-18 17:36:27.134413	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	DEV	\N	\N	3461785316
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-04-18 17:36:27.146435	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	DEV	\N	\N	3461785316
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-04-18 17:36:27.274848	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	DEV	\N	\N	3461785316
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-04-18 17:36:27.378122	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	DEV	\N	\N	3461785316
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-04-18 17:36:27.387852	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	DEV	\N	\N	3461785316
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-04-18 17:36:29.224131	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	DEV	\N	\N	3461785316
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-04-18 17:36:27.390806	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	DEV	\N	\N	3461785316
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-04-18 17:36:27.396457	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	DEV	\N	\N	3461785316
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-04-18 17:36:27.474997	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	DEV	\N	\N	3461785316
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-04-18 17:36:27.48535	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	DEV	\N	\N	3461785316
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-04-18 17:36:27.489063	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	DEV	\N	\N	3461785316
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-04-18 17:36:27.687282	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	DEV	\N	\N	3461785316
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-04-18 17:36:27.802885	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	DEV	\N	\N	3461785316
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-04-18 17:36:27.808791	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	DEV	\N	\N	3461785316
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-04-18 17:36:27.917677	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	DEV	\N	\N	3461785316
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-04-18 17:36:27.941927	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	DEV	\N	\N	3461785316
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-04-18 17:36:28.144068	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	DEV	\N	\N	3461785316
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-04-18 17:36:28.156301	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	DEV	\N	\N	3461785316
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-04-18 17:36:28.169476	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	DEV	\N	\N	3461785316
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-04-18 17:36:28.172509	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	DEV	\N	\N	3461785316
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-04-18 17:36:28.227186	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	DEV	\N	\N	3461785316
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-04-18 17:36:28.260727	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	DEV	\N	\N	3461785316
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-04-18 17:36:28.272768	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	DEV	\N	\N	3461785316
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-04-18 17:36:28.283338	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	DEV	\N	\N	3461785316
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-04-18 17:36:28.302946	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	DEV	\N	\N	3461785316
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-04-18 17:36:28.305992	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	DEV	\N	\N	3461785316
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-04-18 17:36:28.31115	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	DEV	\N	\N	3461785316
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-04-18 17:36:28.321659	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	DEV	\N	\N	3461785316
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-04-18 17:36:29.17787	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	DEV	\N	\N	3461785316
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-04-18 17:36:29.205978	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	DEV	\N	\N	3461785316
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-04-18 17:36:29.214125	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	DEV	\N	\N	3461785316
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-04-18 17:36:29.228045	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	DEV	\N	\N	3461785316
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-04-18 17:36:29.333984	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	DEV	\N	\N	3461785316
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-04-18 17:36:29.361438	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	DEV	\N	\N	3461785316
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-04-18 17:36:29.460815	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	DEV	\N	\N	3461785316
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-04-18 17:36:29.615578	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	DEV	\N	\N	3461785316
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-04-18 17:36:29.622858	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	3461785316
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-04-18 17:36:29.628994	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	DEV	\N	\N	3461785316
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-04-18 17:36:29.634238	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	DEV	\N	\N	3461785316
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-04-18 17:36:29.650805	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	DEV	\N	\N	3461785316
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-04-18 17:36:29.661239	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	DEV	\N	\N	3461785316
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-04-18 17:36:29.730486	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	DEV	\N	\N	3461785316
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-04-18 17:36:30.176318	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	DEV	\N	\N	3461785316
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-04-18 17:36:30.2577	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	DEV	\N	\N	3461785316
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-04-18 17:36:30.268457	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	DEV	\N	\N	3461785316
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-04-18 17:36:30.28138	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	DEV	\N	\N	3461785316
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-04-18 17:36:30.292801	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	DEV	\N	\N	3461785316
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-04-18 17:36:30.300097	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	DEV	\N	\N	3461785316
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-04-18 17:36:30.305435	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	DEV	\N	\N	3461785316
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-04-18 17:36:30.310418	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	DEV	\N	\N	3461785316
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-04-18 17:36:30.340484	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	DEV	\N	\N	3461785316
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-04-18 17:36:30.362735	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	DEV	\N	\N	3461785316
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-04-18 17:36:30.40926	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	DEV	\N	\N	3461785316
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-04-18 17:36:30.448724	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	DEV	\N	\N	3461785316
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-04-18 17:36:30.463233	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	DEV	\N	\N	3461785316
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-04-18 17:36:30.476271	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	DEV	\N	\N	3461785316
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-04-18 17:36:30.489037	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	DEV	\N	\N	3461785316
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-04-18 17:36:30.500637	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	DEV	\N	\N	3461785316
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-04-18 17:36:30.503922	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	DEV	\N	\N	3461785316
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-04-18 17:36:30.539981	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	DEV	\N	\N	3461785316
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-04-18 17:36:30.56524	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	DEV	\N	\N	3461785316
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-04-18 17:36:30.583282	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	DEV	\N	\N	3461785316
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-04-18 17:36:30.587094	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	DEV	\N	\N	3461785316
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-04-18 17:36:30.615773	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	DEV	\N	\N	3461785316
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-04-18 17:36:30.619078	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	DEV	\N	\N	3461785316
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-04-18 17:36:30.641551	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	DEV	\N	\N	3461785316
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-04-18 17:36:30.645271	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	DEV	\N	\N	3461785316
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-04-18 17:36:30.657708	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	DEV	\N	\N	3461785316
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-04-18 17:36:30.661497	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	DEV	\N	\N	3461785316
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-04-18 17:36:30.684472	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	DEV	\N	\N	3461785316
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-04-18 17:36:30.695543	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	DEV	\N	\N	3461785316
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-04-18 17:36:30.708895	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	DEV	\N	\N	3461785316
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-04-18 17:36:30.725317	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	DEV	\N	\N	3461785316
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-04-18 17:36:30.736044	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	DEV	\N	\N	3461785316
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-04-18 17:36:30.747155	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	DEV	\N	\N	3461785316
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-04-18 17:36:30.780143	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	DEV	\N	\N	3461785316
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-04-18 17:36:30.793177	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	DEV	\N	\N	3461785316
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-04-18 17:36:30.796392	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	DEV	\N	\N	3461785316
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-04-18 17:36:30.810182	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	DEV	\N	\N	3461785316
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-04-18 17:36:30.813206	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	DEV	\N	\N	3461785316
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-04-18 17:36:30.826641	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	DEV	\N	\N	3461785316
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-04-18 17:36:31.02435	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	DEV	\N	\N	3461785316
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-04-18 17:36:31.029979	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	3461785316
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-04-18 17:36:31.050378	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	3461785316
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-04-18 17:36:31.08937	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	3461785316
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-04-18 17:36:31.099385	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	3461785316
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-04-18 17:36:31.126005	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	DEV	\N	\N	3461785316
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-04-18 17:36:31.133778	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	DEV	\N	\N	3461785316
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-04-18 17:36:31.145636	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	DEV	\N	\N	3461785316
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2024-04-18 17:36:31.17061	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	DEV	\N	\N	3461785316
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2024-04-18 17:36:31.191448	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	DEV	\N	\N	3461785316
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	7994d91d-57f1-4bc4-85a4-890e1902b0a6	f
d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	af51769a-bda1-4a90-b02c-c94869683f6f	t
d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	daaca0cf-b188-4b18-9aa4-034d4cd520f5	t
d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	2882b34f-51ea-46fc-942d-42c538a0273f	t
d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	b6e78155-3230-48bf-926f-42810df57221	f
d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	d8975a12-e354-4238-b7a2-0591608b4ea7	f
d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	40912194-5035-4bc0-b6c7-d757bf59238c	t
d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	082bd494-02e2-4528-ae06-a46b608f4984	t
d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	2655b3cd-512e-4b3c-b75b-f436ba6b3dc3	f
d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	36fb8f6a-6640-45ab-a7f1-04b7d7563179	t
test	0f30651e-7405-4704-b7bf-a2474bb84359	f
test	5f9763f7-e859-4460-a729-891db0d53f67	t
test	0153ea9f-e3be-44a7-9168-2f48fe701d40	t
test	c9bc44e8-084d-4244-846b-888512b9e68c	t
test	d7a41e7f-ab51-4f26-99fc-449229dc6a82	f
test	59c13612-9b23-4e7c-ad68-128ab9644df4	f
test	a7636dab-db04-4308-9aca-fc43a510fad2	t
test	cd7eac36-2798-44ed-ad14-c071f00ad0b2	t
test	5eaf5b65-1031-4831-bf00-8db3746d8e28	f
test	61c9941a-cbbe-4e1b-8563-2bd9036485d8	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
d1d03d49-5085-4e4d-9bba-80da7ec478e2	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	f	${role_default-roles}	default-roles-master	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N	\N
692ff45c-c18a-4f35-b9cd-076ed09f5133	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	f	${role_admin}	admin	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N	\N
fd43e617-7e85-478e-b743-0591cb8504a7	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	f	${role_create-realm}	create-realm	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N	\N
4398a377-de49-49d8-8d97-912d0086f428	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_create-client}	create-client	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
c40e92d5-961c-4f0c-8b80-ae98faeb3018	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_view-realm}	view-realm	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
cd35990a-9e76-444a-a0bd-b31bb50fe658	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_view-users}	view-users	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
62c298ee-f6fc-455e-aaee-7a60129590e0	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_view-clients}	view-clients	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
39a4fba2-1d3a-459f-b465-49666408cbde	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_view-events}	view-events	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
6071c19e-f4b6-4836-8c4e-8a64d9a007f9	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_view-identity-providers}	view-identity-providers	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
811ea7b4-8272-4fc3-a73e-fe17ec69ff3d	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_view-authorization}	view-authorization	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
23ef7816-9589-4f6f-bfa3-33dad88dff00	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_manage-realm}	manage-realm	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
b5807e22-5c9f-4810-9e2e-ada1a1921859	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_manage-users}	manage-users	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
6c6badf2-4a97-4608-a53a-4473edcf96ca	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_manage-clients}	manage-clients	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
d8d9fd0e-1a8c-4759-bc38-164148d8eeb6	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_manage-events}	manage-events	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
2fa92d11-26c0-4bbc-a175-465d8d299b75	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_manage-identity-providers}	manage-identity-providers	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
2bd49ab8-0e09-4b23-afb3-4abb95d2e815	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_manage-authorization}	manage-authorization	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
0d247991-54f5-459e-bf4f-9cd2afe0f047	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_query-users}	query-users	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
bdaa4862-260e-4b1e-a6b1-bbef9d1bc71d	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_query-clients}	query-clients	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
ef00b9d7-f31a-4d89-866c-a17c08452214	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_query-realms}	query-realms	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
f1671e39-5a49-450d-a56f-9d699da7ef9f	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_query-groups}	query-groups	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
90424b37-6fd0-4695-8128-296e232d0abf	65465689-8e6f-4ee5-8cd5-353c9e715b51	t	${role_view-profile}	view-profile	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	65465689-8e6f-4ee5-8cd5-353c9e715b51	\N
9fe6195e-9708-4aec-a1af-1d3ea5a0e329	65465689-8e6f-4ee5-8cd5-353c9e715b51	t	${role_manage-account}	manage-account	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	65465689-8e6f-4ee5-8cd5-353c9e715b51	\N
db5496cb-33c7-43cd-bd1f-c60731a126a9	65465689-8e6f-4ee5-8cd5-353c9e715b51	t	${role_manage-account-links}	manage-account-links	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	65465689-8e6f-4ee5-8cd5-353c9e715b51	\N
3b9a4249-0041-4e1d-a7ca-6bcba365e5ca	65465689-8e6f-4ee5-8cd5-353c9e715b51	t	${role_view-applications}	view-applications	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	65465689-8e6f-4ee5-8cd5-353c9e715b51	\N
651c5774-00d7-4cc0-819d-3e6fdd3721f2	65465689-8e6f-4ee5-8cd5-353c9e715b51	t	${role_view-consent}	view-consent	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	65465689-8e6f-4ee5-8cd5-353c9e715b51	\N
e8eb1c80-4560-404b-8438-15bf2b210253	65465689-8e6f-4ee5-8cd5-353c9e715b51	t	${role_manage-consent}	manage-consent	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	65465689-8e6f-4ee5-8cd5-353c9e715b51	\N
8c83041f-5459-447a-81f7-106e4922c6a4	65465689-8e6f-4ee5-8cd5-353c9e715b51	t	${role_delete-account}	delete-account	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	65465689-8e6f-4ee5-8cd5-353c9e715b51	\N
5d4c4505-b611-481c-a48a-33494fae91c1	3a103147-3781-4a74-912c-07dea281508b	t	${role_read-token}	read-token	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	3a103147-3781-4a74-912c-07dea281508b	\N
f0d1ebf0-38c6-4c0d-a70b-8e6b218fbfb4	0529c703-ef05-4a9a-8d6a-54270d8af0f6	t	${role_impersonation}	impersonation	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	0529c703-ef05-4a9a-8d6a-54270d8af0f6	\N
7c25dfff-9ebd-4eae-b3bb-3cd418cb3531	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	f	${role_offline-access}	offline_access	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N	\N
93573320-e370-4d8b-bfed-820fc20f8249	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	f	${role_uma_authorization}	uma_authorization	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	\N	\N
450c5b8b-dfb6-432a-a184-9b472ef77f86	test	f	${role_default-roles}	default-roles-test	test	\N	\N
05e60180-0ff5-4bf4-9eef-5b6cc6b970bc	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_create-client}	create-client	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
d4194e70-2276-430d-9d56-4395535e0d13	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_view-realm}	view-realm	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
376ba33f-7934-41d0-a53d-f08d218a07db	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_view-users}	view-users	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
e0b5492f-c5c0-4ce8-87c3-40426f88dc4f	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_view-clients}	view-clients	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
371c369f-a6e5-44a5-9f48-f9e580771107	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_view-events}	view-events	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
61c937b9-8c11-4e5d-b287-4d36f50bc147	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_view-identity-providers}	view-identity-providers	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
10daa0cb-9513-43a4-8fab-b69284909058	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_view-authorization}	view-authorization	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
3723d33d-9647-478d-a60e-78228cdeb91d	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_manage-realm}	manage-realm	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
cf20a14f-7f36-47e1-9082-f02d646c1725	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_manage-users}	manage-users	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
fd0a3875-df3d-4808-9876-85def46e4720	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_manage-clients}	manage-clients	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
3c45d12c-0daf-4690-af59-6153fe38b68a	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_manage-events}	manage-events	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
d5d2450d-382b-4af6-9909-bffdc43009c1	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_manage-identity-providers}	manage-identity-providers	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
ab18ae86-8b38-49ed-9da0-0d0d36c9998d	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_manage-authorization}	manage-authorization	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
bebb48d8-c24c-4620-9763-391d1716fcec	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_query-users}	query-users	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
7e9a9599-3433-44ec-974f-9bb087ce76fb	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_query-clients}	query-clients	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
89e1ada2-0640-426e-bfa7-9278723991a4	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_query-realms}	query-realms	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
efb7bdce-616e-48a6-bb0d-1ef1a5a66ceb	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_query-groups}	query-groups	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
42ae75b3-ffa4-4866-9e2f-f492a6c34fb2	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_realm-admin}	realm-admin	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
042c036f-3734-4123-aa73-a91f9358e93d	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_create-client}	create-client	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
f9899486-64eb-4965-b026-b2edc84d83ee	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_view-realm}	view-realm	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
8353376d-8a19-4b57-b350-d2bd55cdeba7	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_view-users}	view-users	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
ba8db325-6452-42f2-b432-19c4e5fdaae0	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_view-clients}	view-clients	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
b0c7f1ef-aee8-4b5e-a427-03cb21f438d1	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_view-events}	view-events	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
c1b15caf-2fac-44f1-9013-982659c36c67	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_view-identity-providers}	view-identity-providers	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
1cf2eb81-1815-4507-a760-cddd18651ada	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_view-authorization}	view-authorization	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
6e90c055-947f-451c-910f-64a3aa50e9c4	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_manage-realm}	manage-realm	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
ecd3f533-cf2d-463c-8a95-23ae872858f0	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_manage-users}	manage-users	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
6960bd5f-757a-4e19-b893-b2de1905bc6d	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_manage-clients}	manage-clients	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
e2f64c12-2c29-4d27-b8a7-7a5db64eaf66	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_manage-events}	manage-events	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
dc232760-9c16-4d35-b2f9-54e356ff963b	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_manage-identity-providers}	manage-identity-providers	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
37a4a476-3b89-40f0-9a12-c1cad2f13c6f	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_manage-authorization}	manage-authorization	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
c96a0478-ab84-48d2-8027-3ab9e8c91d09	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_query-users}	query-users	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
11bf4e9e-0cab-4cc9-a7f5-edd115cf1e68	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_query-clients}	query-clients	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
7097b1b9-fec8-4b6f-8acc-5b22d2a61021	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_query-realms}	query-realms	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
2a801268-f904-4ee5-954e-7a745fdb4487	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_query-groups}	query-groups	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
0a47f304-8cdf-4084-a840-d700ac803fd5	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	t	${role_view-profile}	view-profile	test	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	\N
6028ea4a-d6cc-40f4-ad4c-ba06a65c7293	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	t	${role_manage-account}	manage-account	test	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	\N
169d607a-a1b2-47c6-a24b-83995664d970	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	t	${role_manage-account-links}	manage-account-links	test	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	\N
c598caf7-9c8f-4b5c-b4c9-d9cd450f6eb9	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	t	${role_view-applications}	view-applications	test	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	\N
3359228f-112e-43f4-8e51-cf4bf82f4d8c	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	t	${role_view-consent}	view-consent	test	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	\N
504c3bc8-4181-47a1-9c7c-c8ea22a9ffd1	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	t	${role_manage-consent}	manage-consent	test	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	\N
73143d5e-167a-4d9f-a8d0-5730a92d30cb	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	t	${role_delete-account}	delete-account	test	e4d55cb1-1907-44fc-a203-e16d9dd48c4c	\N
4256d2e6-9c73-4ae6-8cc5-6226ab57e7b6	845688f8-735c-4c14-a109-ea8a171d0ca7	t	${role_impersonation}	impersonation	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	845688f8-735c-4c14-a109-ea8a171d0ca7	\N
488d99ac-a949-472c-bf24-9b0e32e85fb8	a4f024b5-eb59-49b7-a181-e3d551907e79	t	${role_impersonation}	impersonation	test	a4f024b5-eb59-49b7-a181-e3d551907e79	\N
17337bd4-6496-4149-971a-2a9fdb379a36	34f13e08-8694-4912-b3fa-891a8c10c501	t	${role_read-token}	read-token	test	34f13e08-8694-4912-b3fa-891a8c10c501	\N
f1a87ee6-0755-4e1a-a56a-d9975df85c07	test	f	${role_offline-access}	offline_access	test	\N	\N
cd6d260c-d103-4482-ab3a-37c8b85bad35	test	f	${role_uma_authorization}	uma_authorization	test	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
8y0i9	18.0.13	1713461794
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: oskeycloak0jbosststxtable; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.oskeycloak0jbosststxtable (statetype, hidden, typename, uidstring, objectstate) FROM stdin;
1	0	EISNAME	0:ffff0a840223:-22844b3c:66215a0e:20	\\x23424501102040000000000b6b6579636c6f616b2d30000000000001000000226a6176613a6a626f73732f64617461736f75726365732f4b6579636c6f616b4453000000
\.


--
-- Data for Name: oskeycloak1jbosststxtable; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.oskeycloak1jbosststxtable (statetype, hidden, typename, uidstring, objectstate) FROM stdin;
1	0	EISNAME	0:ffff0a87000e:-205e93bf:66215a51:1b	\\x23424501102040000000000b6b6579636c6f616b2d31000000000001000000226a6176613a6a626f73732f64617461736f75726365732f4b6579636c6f616b4453000000
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
aa736e25-6cea-4d59-b5e7-645b28b3cacd	audience resolve	openid-connect	oidc-audience-resolve-mapper	df65ddb1-74e2-4763-9ef8-598d4eea9120	\N
45ec437d-5943-4dc1-99a3-38520ee3afd6	locale	openid-connect	oidc-usermodel-attribute-mapper	e48a8fee-4299-444c-915b-f68d37bbf1fd	\N
ea534a42-dc5b-4228-a666-a99093d30277	role list	saml	saml-role-list-mapper	\N	af51769a-bda1-4a90-b02c-c94869683f6f
38b72cb8-5691-4d56-ab26-40546f9d784c	full name	openid-connect	oidc-full-name-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
8dfa0192-975b-4492-87df-f31f0774cce6	family name	openid-connect	oidc-usermodel-property-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
20902d96-cafd-4170-bc86-0c6f686aab26	given name	openid-connect	oidc-usermodel-property-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
86d3d6a5-1105-44e4-b4ea-ebf595697fc6	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
47b89e34-2e5d-4376-b990-169d14fb6f22	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
c503a14d-ca0d-4ca8-97ea-95288780b349	username	openid-connect	oidc-usermodel-property-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
ea8bdf5e-429a-42cb-a29a-151625cf4939	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
6c3c3405-2820-4557-a851-0b561112888d	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
44d93731-1d49-4294-a7b8-5261481a94e7	website	openid-connect	oidc-usermodel-attribute-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
b84d117a-e60d-47d7-9b60-4052648875d5	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
8998189e-18c8-405f-bdbd-3fa749aa98c4	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
77dc27b3-4bea-4564-9491-812e564eaf3b	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
29dae9b3-cc48-445b-a958-1fcc7f249312	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
bbf9cd53-1eed-4e4e-8d62-5add940be7ad	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	daaca0cf-b188-4b18-9aa4-034d4cd520f5
eb467c7a-3f34-4daa-9cd0-e04b5e92e3c9	email	openid-connect	oidc-usermodel-property-mapper	\N	2882b34f-51ea-46fc-942d-42c538a0273f
44746876-5c5f-47c2-b59c-987aed59e66b	email verified	openid-connect	oidc-usermodel-property-mapper	\N	2882b34f-51ea-46fc-942d-42c538a0273f
612c7011-506f-4b92-8797-02adebb81624	address	openid-connect	oidc-address-mapper	\N	b6e78155-3230-48bf-926f-42810df57221
e18c2965-5026-469f-aee0-8620f5b9c3c2	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	d8975a12-e354-4238-b7a2-0591608b4ea7
57f6fcf2-58ab-4b3c-b6dd-83938415efa9	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	d8975a12-e354-4238-b7a2-0591608b4ea7
3d8d5857-f8e4-47c8-99ea-7fe34c45812f	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	40912194-5035-4bc0-b6c7-d757bf59238c
a2beb574-9441-4d39-8d53-6da59335dba3	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	40912194-5035-4bc0-b6c7-d757bf59238c
e035ff03-8e98-40f4-aa10-6ae049b4807b	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	40912194-5035-4bc0-b6c7-d757bf59238c
59af4bcb-2211-4280-8d26-49adb29bfc5b	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	082bd494-02e2-4528-ae06-a46b608f4984
0a080e21-960d-4b0d-8da2-662f8d06aaaa	upn	openid-connect	oidc-usermodel-property-mapper	\N	2655b3cd-512e-4b3c-b75b-f436ba6b3dc3
8aa2df45-938e-485e-afce-f56808552fef	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	2655b3cd-512e-4b3c-b75b-f436ba6b3dc3
ec72025d-c566-4615-a85b-994f256f3e8a	acr loa level	openid-connect	oidc-acr-mapper	\N	36fb8f6a-6640-45ab-a7f1-04b7d7563179
45950874-a188-4755-b157-ce2db69fcbcf	audience resolve	openid-connect	oidc-audience-resolve-mapper	02db0790-23bc-49ac-bee0-5fae3c56f316	\N
43909af6-a8c4-4eec-a266-c2c760ec3eac	role list	saml	saml-role-list-mapper	\N	5f9763f7-e859-4460-a729-891db0d53f67
8d65aab0-dc5a-4d16-b2ae-39f4ddd05b25	full name	openid-connect	oidc-full-name-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
0933d09d-2259-4605-a110-d93fe6a8aa49	family name	openid-connect	oidc-usermodel-property-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
2c64618e-3796-4d76-891d-eccff3610a29	given name	openid-connect	oidc-usermodel-property-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
1f825766-c6ba-49ac-9e21-b51fbc8876bb	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
e15af9af-95cb-4f28-9cf2-9e71326e8090	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
7feca481-c6c3-4bf9-894b-6057e49f1205	username	openid-connect	oidc-usermodel-property-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
9a0e646e-0d62-4357-82b2-c41ad4c2f76d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
b6fcd801-e743-4b6f-96f2-8e110c33d14b	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
9cbc08c5-348b-47ec-bad0-74d4c14d0ec9	website	openid-connect	oidc-usermodel-attribute-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
a0b7b913-fc83-4e06-8907-42c12c06069a	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
d2ff6bec-eac0-4726-a658-47b2744c896a	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
f4c7c324-1a7c-486c-bad7-8447d5c17ff5	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
f3a94286-11ef-4675-bac5-221ad9e9dc99	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
ea7e957a-2666-4791-b5c8-3d669e2770e8	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	0153ea9f-e3be-44a7-9168-2f48fe701d40
ef5095ac-824a-4627-98b4-c806d7602ec5	email	openid-connect	oidc-usermodel-property-mapper	\N	c9bc44e8-084d-4244-846b-888512b9e68c
099e4695-5469-4e4b-90ea-adb602d9f183	email verified	openid-connect	oidc-usermodel-property-mapper	\N	c9bc44e8-084d-4244-846b-888512b9e68c
da4c5472-a511-4a4e-bce8-ad0472ec254f	address	openid-connect	oidc-address-mapper	\N	d7a41e7f-ab51-4f26-99fc-449229dc6a82
5a47838c-6f6e-4a4c-9248-2d3fb7911f5c	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	59c13612-9b23-4e7c-ad68-128ab9644df4
c00041f9-0ddb-4412-9b68-c74d5806b501	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	59c13612-9b23-4e7c-ad68-128ab9644df4
e76aaa44-b825-4509-af7b-e331dae8d485	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	a7636dab-db04-4308-9aca-fc43a510fad2
225900d6-ecef-454d-ac5c-398b82f86275	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	a7636dab-db04-4308-9aca-fc43a510fad2
bff0256f-b37e-49c0-9b63-e318c6124037	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	a7636dab-db04-4308-9aca-fc43a510fad2
5abb5af4-797d-4b44-84fd-18e52b5673f6	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	cd7eac36-2798-44ed-ad14-c071f00ad0b2
4f08935d-927c-4bed-be80-3b6e3794abe6	upn	openid-connect	oidc-usermodel-property-mapper	\N	5eaf5b65-1031-4831-bf00-8db3746d8e28
04749e5c-7ec7-46d8-a009-2d69d577f426	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	5eaf5b65-1031-4831-bf00-8db3746d8e28
77217fe5-458a-4539-ae4f-1ac73336cef8	acr loa level	openid-connect	oidc-acr-mapper	\N	61c9941a-cbbe-4e1b-8563-2bd9036485d8
ea20e08c-381b-4298-a9e8-f09096db2651	locale	openid-connect	oidc-usermodel-attribute-mapper	5a3f72bf-aacd-4096-b3fb-4065b7f31083	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
45ec437d-5943-4dc1-99a3-38520ee3afd6	true	userinfo.token.claim
45ec437d-5943-4dc1-99a3-38520ee3afd6	locale	user.attribute
45ec437d-5943-4dc1-99a3-38520ee3afd6	true	id.token.claim
45ec437d-5943-4dc1-99a3-38520ee3afd6	true	access.token.claim
45ec437d-5943-4dc1-99a3-38520ee3afd6	locale	claim.name
45ec437d-5943-4dc1-99a3-38520ee3afd6	String	jsonType.label
ea534a42-dc5b-4228-a666-a99093d30277	false	single
ea534a42-dc5b-4228-a666-a99093d30277	Basic	attribute.nameformat
ea534a42-dc5b-4228-a666-a99093d30277	Role	attribute.name
38b72cb8-5691-4d56-ab26-40546f9d784c	true	userinfo.token.claim
38b72cb8-5691-4d56-ab26-40546f9d784c	true	id.token.claim
38b72cb8-5691-4d56-ab26-40546f9d784c	true	access.token.claim
8dfa0192-975b-4492-87df-f31f0774cce6	true	userinfo.token.claim
8dfa0192-975b-4492-87df-f31f0774cce6	lastName	user.attribute
8dfa0192-975b-4492-87df-f31f0774cce6	true	id.token.claim
8dfa0192-975b-4492-87df-f31f0774cce6	true	access.token.claim
8dfa0192-975b-4492-87df-f31f0774cce6	family_name	claim.name
8dfa0192-975b-4492-87df-f31f0774cce6	String	jsonType.label
20902d96-cafd-4170-bc86-0c6f686aab26	true	userinfo.token.claim
20902d96-cafd-4170-bc86-0c6f686aab26	firstName	user.attribute
20902d96-cafd-4170-bc86-0c6f686aab26	true	id.token.claim
20902d96-cafd-4170-bc86-0c6f686aab26	true	access.token.claim
20902d96-cafd-4170-bc86-0c6f686aab26	given_name	claim.name
20902d96-cafd-4170-bc86-0c6f686aab26	String	jsonType.label
86d3d6a5-1105-44e4-b4ea-ebf595697fc6	true	userinfo.token.claim
86d3d6a5-1105-44e4-b4ea-ebf595697fc6	middleName	user.attribute
86d3d6a5-1105-44e4-b4ea-ebf595697fc6	true	id.token.claim
86d3d6a5-1105-44e4-b4ea-ebf595697fc6	true	access.token.claim
86d3d6a5-1105-44e4-b4ea-ebf595697fc6	middle_name	claim.name
86d3d6a5-1105-44e4-b4ea-ebf595697fc6	String	jsonType.label
47b89e34-2e5d-4376-b990-169d14fb6f22	true	userinfo.token.claim
47b89e34-2e5d-4376-b990-169d14fb6f22	nickname	user.attribute
47b89e34-2e5d-4376-b990-169d14fb6f22	true	id.token.claim
47b89e34-2e5d-4376-b990-169d14fb6f22	true	access.token.claim
47b89e34-2e5d-4376-b990-169d14fb6f22	nickname	claim.name
47b89e34-2e5d-4376-b990-169d14fb6f22	String	jsonType.label
c503a14d-ca0d-4ca8-97ea-95288780b349	true	userinfo.token.claim
c503a14d-ca0d-4ca8-97ea-95288780b349	username	user.attribute
c503a14d-ca0d-4ca8-97ea-95288780b349	true	id.token.claim
c503a14d-ca0d-4ca8-97ea-95288780b349	true	access.token.claim
c503a14d-ca0d-4ca8-97ea-95288780b349	preferred_username	claim.name
c503a14d-ca0d-4ca8-97ea-95288780b349	String	jsonType.label
ea8bdf5e-429a-42cb-a29a-151625cf4939	true	userinfo.token.claim
ea8bdf5e-429a-42cb-a29a-151625cf4939	profile	user.attribute
ea8bdf5e-429a-42cb-a29a-151625cf4939	true	id.token.claim
ea8bdf5e-429a-42cb-a29a-151625cf4939	true	access.token.claim
ea8bdf5e-429a-42cb-a29a-151625cf4939	profile	claim.name
ea8bdf5e-429a-42cb-a29a-151625cf4939	String	jsonType.label
6c3c3405-2820-4557-a851-0b561112888d	true	userinfo.token.claim
6c3c3405-2820-4557-a851-0b561112888d	picture	user.attribute
6c3c3405-2820-4557-a851-0b561112888d	true	id.token.claim
6c3c3405-2820-4557-a851-0b561112888d	true	access.token.claim
6c3c3405-2820-4557-a851-0b561112888d	picture	claim.name
6c3c3405-2820-4557-a851-0b561112888d	String	jsonType.label
44d93731-1d49-4294-a7b8-5261481a94e7	true	userinfo.token.claim
44d93731-1d49-4294-a7b8-5261481a94e7	website	user.attribute
44d93731-1d49-4294-a7b8-5261481a94e7	true	id.token.claim
44d93731-1d49-4294-a7b8-5261481a94e7	true	access.token.claim
44d93731-1d49-4294-a7b8-5261481a94e7	website	claim.name
44d93731-1d49-4294-a7b8-5261481a94e7	String	jsonType.label
b84d117a-e60d-47d7-9b60-4052648875d5	true	userinfo.token.claim
b84d117a-e60d-47d7-9b60-4052648875d5	gender	user.attribute
b84d117a-e60d-47d7-9b60-4052648875d5	true	id.token.claim
b84d117a-e60d-47d7-9b60-4052648875d5	true	access.token.claim
b84d117a-e60d-47d7-9b60-4052648875d5	gender	claim.name
b84d117a-e60d-47d7-9b60-4052648875d5	String	jsonType.label
8998189e-18c8-405f-bdbd-3fa749aa98c4	true	userinfo.token.claim
8998189e-18c8-405f-bdbd-3fa749aa98c4	birthdate	user.attribute
8998189e-18c8-405f-bdbd-3fa749aa98c4	true	id.token.claim
8998189e-18c8-405f-bdbd-3fa749aa98c4	true	access.token.claim
8998189e-18c8-405f-bdbd-3fa749aa98c4	birthdate	claim.name
8998189e-18c8-405f-bdbd-3fa749aa98c4	String	jsonType.label
77dc27b3-4bea-4564-9491-812e564eaf3b	true	userinfo.token.claim
77dc27b3-4bea-4564-9491-812e564eaf3b	zoneinfo	user.attribute
77dc27b3-4bea-4564-9491-812e564eaf3b	true	id.token.claim
77dc27b3-4bea-4564-9491-812e564eaf3b	true	access.token.claim
77dc27b3-4bea-4564-9491-812e564eaf3b	zoneinfo	claim.name
77dc27b3-4bea-4564-9491-812e564eaf3b	String	jsonType.label
29dae9b3-cc48-445b-a958-1fcc7f249312	true	userinfo.token.claim
29dae9b3-cc48-445b-a958-1fcc7f249312	locale	user.attribute
29dae9b3-cc48-445b-a958-1fcc7f249312	true	id.token.claim
29dae9b3-cc48-445b-a958-1fcc7f249312	true	access.token.claim
29dae9b3-cc48-445b-a958-1fcc7f249312	locale	claim.name
29dae9b3-cc48-445b-a958-1fcc7f249312	String	jsonType.label
bbf9cd53-1eed-4e4e-8d62-5add940be7ad	true	userinfo.token.claim
bbf9cd53-1eed-4e4e-8d62-5add940be7ad	updatedAt	user.attribute
bbf9cd53-1eed-4e4e-8d62-5add940be7ad	true	id.token.claim
bbf9cd53-1eed-4e4e-8d62-5add940be7ad	true	access.token.claim
bbf9cd53-1eed-4e4e-8d62-5add940be7ad	updated_at	claim.name
bbf9cd53-1eed-4e4e-8d62-5add940be7ad	long	jsonType.label
eb467c7a-3f34-4daa-9cd0-e04b5e92e3c9	true	userinfo.token.claim
eb467c7a-3f34-4daa-9cd0-e04b5e92e3c9	email	user.attribute
eb467c7a-3f34-4daa-9cd0-e04b5e92e3c9	true	id.token.claim
eb467c7a-3f34-4daa-9cd0-e04b5e92e3c9	true	access.token.claim
eb467c7a-3f34-4daa-9cd0-e04b5e92e3c9	email	claim.name
eb467c7a-3f34-4daa-9cd0-e04b5e92e3c9	String	jsonType.label
44746876-5c5f-47c2-b59c-987aed59e66b	true	userinfo.token.claim
44746876-5c5f-47c2-b59c-987aed59e66b	emailVerified	user.attribute
44746876-5c5f-47c2-b59c-987aed59e66b	true	id.token.claim
44746876-5c5f-47c2-b59c-987aed59e66b	true	access.token.claim
44746876-5c5f-47c2-b59c-987aed59e66b	email_verified	claim.name
44746876-5c5f-47c2-b59c-987aed59e66b	boolean	jsonType.label
612c7011-506f-4b92-8797-02adebb81624	formatted	user.attribute.formatted
612c7011-506f-4b92-8797-02adebb81624	country	user.attribute.country
612c7011-506f-4b92-8797-02adebb81624	postal_code	user.attribute.postal_code
612c7011-506f-4b92-8797-02adebb81624	true	userinfo.token.claim
612c7011-506f-4b92-8797-02adebb81624	street	user.attribute.street
612c7011-506f-4b92-8797-02adebb81624	true	id.token.claim
612c7011-506f-4b92-8797-02adebb81624	region	user.attribute.region
612c7011-506f-4b92-8797-02adebb81624	true	access.token.claim
612c7011-506f-4b92-8797-02adebb81624	locality	user.attribute.locality
e18c2965-5026-469f-aee0-8620f5b9c3c2	true	userinfo.token.claim
e18c2965-5026-469f-aee0-8620f5b9c3c2	phoneNumber	user.attribute
e18c2965-5026-469f-aee0-8620f5b9c3c2	true	id.token.claim
e18c2965-5026-469f-aee0-8620f5b9c3c2	true	access.token.claim
e18c2965-5026-469f-aee0-8620f5b9c3c2	phone_number	claim.name
e18c2965-5026-469f-aee0-8620f5b9c3c2	String	jsonType.label
57f6fcf2-58ab-4b3c-b6dd-83938415efa9	true	userinfo.token.claim
57f6fcf2-58ab-4b3c-b6dd-83938415efa9	phoneNumberVerified	user.attribute
57f6fcf2-58ab-4b3c-b6dd-83938415efa9	true	id.token.claim
57f6fcf2-58ab-4b3c-b6dd-83938415efa9	true	access.token.claim
57f6fcf2-58ab-4b3c-b6dd-83938415efa9	phone_number_verified	claim.name
57f6fcf2-58ab-4b3c-b6dd-83938415efa9	boolean	jsonType.label
3d8d5857-f8e4-47c8-99ea-7fe34c45812f	true	multivalued
3d8d5857-f8e4-47c8-99ea-7fe34c45812f	foo	user.attribute
3d8d5857-f8e4-47c8-99ea-7fe34c45812f	true	access.token.claim
3d8d5857-f8e4-47c8-99ea-7fe34c45812f	realm_access.roles	claim.name
3d8d5857-f8e4-47c8-99ea-7fe34c45812f	String	jsonType.label
a2beb574-9441-4d39-8d53-6da59335dba3	true	multivalued
a2beb574-9441-4d39-8d53-6da59335dba3	foo	user.attribute
a2beb574-9441-4d39-8d53-6da59335dba3	true	access.token.claim
a2beb574-9441-4d39-8d53-6da59335dba3	resource_access.${client_id}.roles	claim.name
a2beb574-9441-4d39-8d53-6da59335dba3	String	jsonType.label
0a080e21-960d-4b0d-8da2-662f8d06aaaa	true	userinfo.token.claim
0a080e21-960d-4b0d-8da2-662f8d06aaaa	username	user.attribute
0a080e21-960d-4b0d-8da2-662f8d06aaaa	true	id.token.claim
0a080e21-960d-4b0d-8da2-662f8d06aaaa	true	access.token.claim
0a080e21-960d-4b0d-8da2-662f8d06aaaa	upn	claim.name
0a080e21-960d-4b0d-8da2-662f8d06aaaa	String	jsonType.label
8aa2df45-938e-485e-afce-f56808552fef	true	multivalued
8aa2df45-938e-485e-afce-f56808552fef	foo	user.attribute
8aa2df45-938e-485e-afce-f56808552fef	true	id.token.claim
8aa2df45-938e-485e-afce-f56808552fef	true	access.token.claim
8aa2df45-938e-485e-afce-f56808552fef	groups	claim.name
8aa2df45-938e-485e-afce-f56808552fef	String	jsonType.label
ec72025d-c566-4615-a85b-994f256f3e8a	true	id.token.claim
ec72025d-c566-4615-a85b-994f256f3e8a	true	access.token.claim
43909af6-a8c4-4eec-a266-c2c760ec3eac	false	single
43909af6-a8c4-4eec-a266-c2c760ec3eac	Basic	attribute.nameformat
43909af6-a8c4-4eec-a266-c2c760ec3eac	Role	attribute.name
8d65aab0-dc5a-4d16-b2ae-39f4ddd05b25	true	userinfo.token.claim
8d65aab0-dc5a-4d16-b2ae-39f4ddd05b25	true	id.token.claim
8d65aab0-dc5a-4d16-b2ae-39f4ddd05b25	true	access.token.claim
0933d09d-2259-4605-a110-d93fe6a8aa49	true	userinfo.token.claim
0933d09d-2259-4605-a110-d93fe6a8aa49	lastName	user.attribute
0933d09d-2259-4605-a110-d93fe6a8aa49	true	id.token.claim
0933d09d-2259-4605-a110-d93fe6a8aa49	true	access.token.claim
0933d09d-2259-4605-a110-d93fe6a8aa49	family_name	claim.name
0933d09d-2259-4605-a110-d93fe6a8aa49	String	jsonType.label
2c64618e-3796-4d76-891d-eccff3610a29	true	userinfo.token.claim
2c64618e-3796-4d76-891d-eccff3610a29	firstName	user.attribute
2c64618e-3796-4d76-891d-eccff3610a29	true	id.token.claim
2c64618e-3796-4d76-891d-eccff3610a29	true	access.token.claim
2c64618e-3796-4d76-891d-eccff3610a29	given_name	claim.name
2c64618e-3796-4d76-891d-eccff3610a29	String	jsonType.label
1f825766-c6ba-49ac-9e21-b51fbc8876bb	true	userinfo.token.claim
1f825766-c6ba-49ac-9e21-b51fbc8876bb	middleName	user.attribute
1f825766-c6ba-49ac-9e21-b51fbc8876bb	true	id.token.claim
1f825766-c6ba-49ac-9e21-b51fbc8876bb	true	access.token.claim
1f825766-c6ba-49ac-9e21-b51fbc8876bb	middle_name	claim.name
1f825766-c6ba-49ac-9e21-b51fbc8876bb	String	jsonType.label
e15af9af-95cb-4f28-9cf2-9e71326e8090	true	userinfo.token.claim
e15af9af-95cb-4f28-9cf2-9e71326e8090	nickname	user.attribute
e15af9af-95cb-4f28-9cf2-9e71326e8090	true	id.token.claim
e15af9af-95cb-4f28-9cf2-9e71326e8090	true	access.token.claim
e15af9af-95cb-4f28-9cf2-9e71326e8090	nickname	claim.name
e15af9af-95cb-4f28-9cf2-9e71326e8090	String	jsonType.label
7feca481-c6c3-4bf9-894b-6057e49f1205	true	userinfo.token.claim
7feca481-c6c3-4bf9-894b-6057e49f1205	username	user.attribute
7feca481-c6c3-4bf9-894b-6057e49f1205	true	id.token.claim
7feca481-c6c3-4bf9-894b-6057e49f1205	true	access.token.claim
7feca481-c6c3-4bf9-894b-6057e49f1205	preferred_username	claim.name
7feca481-c6c3-4bf9-894b-6057e49f1205	String	jsonType.label
9a0e646e-0d62-4357-82b2-c41ad4c2f76d	true	userinfo.token.claim
9a0e646e-0d62-4357-82b2-c41ad4c2f76d	profile	user.attribute
9a0e646e-0d62-4357-82b2-c41ad4c2f76d	true	id.token.claim
9a0e646e-0d62-4357-82b2-c41ad4c2f76d	true	access.token.claim
9a0e646e-0d62-4357-82b2-c41ad4c2f76d	profile	claim.name
9a0e646e-0d62-4357-82b2-c41ad4c2f76d	String	jsonType.label
b6fcd801-e743-4b6f-96f2-8e110c33d14b	true	userinfo.token.claim
b6fcd801-e743-4b6f-96f2-8e110c33d14b	picture	user.attribute
b6fcd801-e743-4b6f-96f2-8e110c33d14b	true	id.token.claim
b6fcd801-e743-4b6f-96f2-8e110c33d14b	true	access.token.claim
b6fcd801-e743-4b6f-96f2-8e110c33d14b	picture	claim.name
b6fcd801-e743-4b6f-96f2-8e110c33d14b	String	jsonType.label
9cbc08c5-348b-47ec-bad0-74d4c14d0ec9	true	userinfo.token.claim
9cbc08c5-348b-47ec-bad0-74d4c14d0ec9	website	user.attribute
9cbc08c5-348b-47ec-bad0-74d4c14d0ec9	true	id.token.claim
9cbc08c5-348b-47ec-bad0-74d4c14d0ec9	true	access.token.claim
9cbc08c5-348b-47ec-bad0-74d4c14d0ec9	website	claim.name
9cbc08c5-348b-47ec-bad0-74d4c14d0ec9	String	jsonType.label
a0b7b913-fc83-4e06-8907-42c12c06069a	true	userinfo.token.claim
a0b7b913-fc83-4e06-8907-42c12c06069a	gender	user.attribute
a0b7b913-fc83-4e06-8907-42c12c06069a	true	id.token.claim
a0b7b913-fc83-4e06-8907-42c12c06069a	true	access.token.claim
a0b7b913-fc83-4e06-8907-42c12c06069a	gender	claim.name
a0b7b913-fc83-4e06-8907-42c12c06069a	String	jsonType.label
d2ff6bec-eac0-4726-a658-47b2744c896a	true	userinfo.token.claim
d2ff6bec-eac0-4726-a658-47b2744c896a	birthdate	user.attribute
d2ff6bec-eac0-4726-a658-47b2744c896a	true	id.token.claim
d2ff6bec-eac0-4726-a658-47b2744c896a	true	access.token.claim
d2ff6bec-eac0-4726-a658-47b2744c896a	birthdate	claim.name
d2ff6bec-eac0-4726-a658-47b2744c896a	String	jsonType.label
f4c7c324-1a7c-486c-bad7-8447d5c17ff5	true	userinfo.token.claim
f4c7c324-1a7c-486c-bad7-8447d5c17ff5	zoneinfo	user.attribute
f4c7c324-1a7c-486c-bad7-8447d5c17ff5	true	id.token.claim
f4c7c324-1a7c-486c-bad7-8447d5c17ff5	true	access.token.claim
f4c7c324-1a7c-486c-bad7-8447d5c17ff5	zoneinfo	claim.name
f4c7c324-1a7c-486c-bad7-8447d5c17ff5	String	jsonType.label
f3a94286-11ef-4675-bac5-221ad9e9dc99	true	userinfo.token.claim
f3a94286-11ef-4675-bac5-221ad9e9dc99	locale	user.attribute
f3a94286-11ef-4675-bac5-221ad9e9dc99	true	id.token.claim
f3a94286-11ef-4675-bac5-221ad9e9dc99	true	access.token.claim
f3a94286-11ef-4675-bac5-221ad9e9dc99	locale	claim.name
f3a94286-11ef-4675-bac5-221ad9e9dc99	String	jsonType.label
ea7e957a-2666-4791-b5c8-3d669e2770e8	true	userinfo.token.claim
ea7e957a-2666-4791-b5c8-3d669e2770e8	updatedAt	user.attribute
ea7e957a-2666-4791-b5c8-3d669e2770e8	true	id.token.claim
ea7e957a-2666-4791-b5c8-3d669e2770e8	true	access.token.claim
ea7e957a-2666-4791-b5c8-3d669e2770e8	updated_at	claim.name
ea7e957a-2666-4791-b5c8-3d669e2770e8	long	jsonType.label
ef5095ac-824a-4627-98b4-c806d7602ec5	true	userinfo.token.claim
ef5095ac-824a-4627-98b4-c806d7602ec5	email	user.attribute
ef5095ac-824a-4627-98b4-c806d7602ec5	true	id.token.claim
ef5095ac-824a-4627-98b4-c806d7602ec5	true	access.token.claim
ef5095ac-824a-4627-98b4-c806d7602ec5	email	claim.name
ef5095ac-824a-4627-98b4-c806d7602ec5	String	jsonType.label
099e4695-5469-4e4b-90ea-adb602d9f183	true	userinfo.token.claim
099e4695-5469-4e4b-90ea-adb602d9f183	emailVerified	user.attribute
099e4695-5469-4e4b-90ea-adb602d9f183	true	id.token.claim
099e4695-5469-4e4b-90ea-adb602d9f183	true	access.token.claim
099e4695-5469-4e4b-90ea-adb602d9f183	email_verified	claim.name
099e4695-5469-4e4b-90ea-adb602d9f183	boolean	jsonType.label
da4c5472-a511-4a4e-bce8-ad0472ec254f	formatted	user.attribute.formatted
da4c5472-a511-4a4e-bce8-ad0472ec254f	country	user.attribute.country
da4c5472-a511-4a4e-bce8-ad0472ec254f	postal_code	user.attribute.postal_code
da4c5472-a511-4a4e-bce8-ad0472ec254f	true	userinfo.token.claim
da4c5472-a511-4a4e-bce8-ad0472ec254f	street	user.attribute.street
da4c5472-a511-4a4e-bce8-ad0472ec254f	true	id.token.claim
da4c5472-a511-4a4e-bce8-ad0472ec254f	region	user.attribute.region
da4c5472-a511-4a4e-bce8-ad0472ec254f	true	access.token.claim
da4c5472-a511-4a4e-bce8-ad0472ec254f	locality	user.attribute.locality
5a47838c-6f6e-4a4c-9248-2d3fb7911f5c	true	userinfo.token.claim
5a47838c-6f6e-4a4c-9248-2d3fb7911f5c	phoneNumber	user.attribute
5a47838c-6f6e-4a4c-9248-2d3fb7911f5c	true	id.token.claim
5a47838c-6f6e-4a4c-9248-2d3fb7911f5c	true	access.token.claim
5a47838c-6f6e-4a4c-9248-2d3fb7911f5c	phone_number	claim.name
5a47838c-6f6e-4a4c-9248-2d3fb7911f5c	String	jsonType.label
c00041f9-0ddb-4412-9b68-c74d5806b501	true	userinfo.token.claim
c00041f9-0ddb-4412-9b68-c74d5806b501	phoneNumberVerified	user.attribute
c00041f9-0ddb-4412-9b68-c74d5806b501	true	id.token.claim
c00041f9-0ddb-4412-9b68-c74d5806b501	true	access.token.claim
c00041f9-0ddb-4412-9b68-c74d5806b501	phone_number_verified	claim.name
c00041f9-0ddb-4412-9b68-c74d5806b501	boolean	jsonType.label
e76aaa44-b825-4509-af7b-e331dae8d485	true	multivalued
e76aaa44-b825-4509-af7b-e331dae8d485	foo	user.attribute
e76aaa44-b825-4509-af7b-e331dae8d485	true	access.token.claim
e76aaa44-b825-4509-af7b-e331dae8d485	realm_access.roles	claim.name
e76aaa44-b825-4509-af7b-e331dae8d485	String	jsonType.label
225900d6-ecef-454d-ac5c-398b82f86275	true	multivalued
225900d6-ecef-454d-ac5c-398b82f86275	foo	user.attribute
225900d6-ecef-454d-ac5c-398b82f86275	true	access.token.claim
225900d6-ecef-454d-ac5c-398b82f86275	resource_access.${client_id}.roles	claim.name
225900d6-ecef-454d-ac5c-398b82f86275	String	jsonType.label
4f08935d-927c-4bed-be80-3b6e3794abe6	true	userinfo.token.claim
4f08935d-927c-4bed-be80-3b6e3794abe6	username	user.attribute
4f08935d-927c-4bed-be80-3b6e3794abe6	true	id.token.claim
4f08935d-927c-4bed-be80-3b6e3794abe6	true	access.token.claim
4f08935d-927c-4bed-be80-3b6e3794abe6	upn	claim.name
4f08935d-927c-4bed-be80-3b6e3794abe6	String	jsonType.label
04749e5c-7ec7-46d8-a009-2d69d577f426	true	multivalued
04749e5c-7ec7-46d8-a009-2d69d577f426	foo	user.attribute
04749e5c-7ec7-46d8-a009-2d69d577f426	true	id.token.claim
04749e5c-7ec7-46d8-a009-2d69d577f426	true	access.token.claim
04749e5c-7ec7-46d8-a009-2d69d577f426	groups	claim.name
04749e5c-7ec7-46d8-a009-2d69d577f426	String	jsonType.label
77217fe5-458a-4539-ae4f-1ac73336cef8	true	id.token.claim
77217fe5-458a-4539-ae4f-1ac73336cef8	true	access.token.claim
ea20e08c-381b-4298-a9e8-f09096db2651	true	userinfo.token.claim
ea20e08c-381b-4298-a9e8-f09096db2651	locale	user.attribute
ea20e08c-381b-4298-a9e8-f09096db2651	true	id.token.claim
ea20e08c-381b-4298-a9e8-f09096db2651	true	access.token.claim
ea20e08c-381b-4298-a9e8-f09096db2651	locale	claim.name
ea20e08c-381b-4298-a9e8-f09096db2651	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	0529c703-ef05-4a9a-8d6a-54270d8af0f6	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	2176bd5a-7258-4f22-91c7-8e082f45f4ce	a40418aa-f3ac-48a9-a074-b4857d96284f	3df2e182-a333-4a71-92db-c7a5dd12b45e	af548bc4-9343-4e54-8106-cb6ec67652da	08f31a64-6626-4b24-9ed3-b1b7825ec9e3	2592000	f	900	t	f	0c95b43c-bea8-455e-9c98-b84c73a6ff65	0	f	0	0	d1d03d49-5085-4e4d-9bba-80da7ec478e2
test	60	300	300	\N	\N	\N	t	f	0	\N	test	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	845688f8-735c-4c14-a109-ea8a171d0ca7	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	c9057b2c-eaa1-4071-b9f8-229eb21c5dcb	be54944e-8a5a-45f0-a9ea-e52f07fdaf15	f1b9edda-64ca-4227-8762-4e229099cb77	2b094ddb-106d-42b1-b8ed-c721b9899573	c1440149-acf8-484f-98fb-cc1eaf243d75	2592000	f	900	t	f	3ba7c4a0-e6a7-42ba-be5e-6eb2f8e324b9	0	f	0	0	450c5b8b-dfb6-432a-a184-9b472ef77f86
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	
_browser_header.xContentTypeOptions	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	nosniff
_browser_header.xRobotsTag	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	none
_browser_header.xFrameOptions	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	SAMEORIGIN
_browser_header.contentSecurityPolicy	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	1; mode=block
_browser_header.strictTransportSecurity	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	max-age=31536000; includeSubDomains
bruteForceProtected	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	false
permanentLockout	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	false
maxFailureWaitSeconds	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	900
minimumQuickLoginWaitSeconds	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	60
waitIncrementSeconds	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	60
quickLoginCheckMilliSeconds	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	1000
maxDeltaTimeSeconds	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	43200
failureFactor	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	30
realmReusableOtpCode	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	false
displayName	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	rh-sso
displayNameHtml	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	<strong>Red Hat</strong><sup>®</sup> Single Sign On
defaultSignatureAlgorithm	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	RS256
offlineSessionMaxLifespanEnabled	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	false
offlineSessionMaxLifespan	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	5184000
_browser_header.contentSecurityPolicyReportOnly	test	
_browser_header.xContentTypeOptions	test	nosniff
_browser_header.xRobotsTag	test	none
_browser_header.xFrameOptions	test	SAMEORIGIN
_browser_header.contentSecurityPolicy	test	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	test	1; mode=block
_browser_header.strictTransportSecurity	test	max-age=31536000; includeSubDomains
bruteForceProtected	test	false
permanentLockout	test	false
maxFailureWaitSeconds	test	900
minimumQuickLoginWaitSeconds	test	60
waitIncrementSeconds	test	60
quickLoginCheckMilliSeconds	test	1000
maxDeltaTimeSeconds	test	43200
failureFactor	test	30
realmReusableOtpCode	test	false
defaultSignatureAlgorithm	test	RS256
offlineSessionMaxLifespanEnabled	test	false
offlineSessionMaxLifespan	test	5184000
actionTokenGeneratedByAdminLifespan	test	43200
actionTokenGeneratedByUserLifespan	test	300
oauth2DeviceCodeLifespan	test	600
oauth2DevicePollingInterval	test	5
webAuthnPolicyRpEntityName	test	keycloak
webAuthnPolicySignatureAlgorithms	test	ES256
webAuthnPolicyRpId	test	
webAuthnPolicyAttestationConveyancePreference	test	not specified
webAuthnPolicyAuthenticatorAttachment	test	not specified
webAuthnPolicyRequireResidentKey	test	not specified
webAuthnPolicyUserVerificationRequirement	test	not specified
webAuthnPolicyCreateTimeout	test	0
webAuthnPolicyAvoidSameAuthenticatorRegister	test	false
webAuthnPolicyRpEntityNamePasswordless	test	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	test	ES256
webAuthnPolicyRpIdPasswordless	test	
webAuthnPolicyAttestationConveyancePreferencePasswordless	test	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	test	not specified
webAuthnPolicyRequireResidentKeyPasswordless	test	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	test	not specified
webAuthnPolicyCreateTimeoutPasswordless	test	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	test	false
cibaBackchannelTokenDeliveryMode	test	poll
cibaExpiresIn	test	120
cibaInterval	test	5
cibaAuthRequestedUserHint	test	login_hint
parRequestUriLifespan	test	60
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	jboss-logging
test	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45
password	password	t	t	test
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
65465689-8e6f-4ee5-8cd5-353c9e715b51	/realms/master/account/*
df65ddb1-74e2-4763-9ef8-598d4eea9120	/realms/master/account/*
e48a8fee-4299-444c-915b-f68d37bbf1fd	/admin/master/console/*
e4d55cb1-1907-44fc-a203-e16d9dd48c4c	/realms/test/account/*
02db0790-23bc-49ac-bee0-5fae3c56f316	/realms/test/account/*
5a3f72bf-aacd-4096-b3fb-4065b7f31083	/admin/test/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
fc61325a-91c3-4db8-872e-53c01f6f8a7e	VERIFY_EMAIL	Verify Email	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	t	f	VERIFY_EMAIL	50
1d2f9e39-9dca-415d-af5e-4caaf49609ac	UPDATE_PROFILE	Update Profile	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	t	f	UPDATE_PROFILE	40
c7def358-8a06-468b-bdf6-6829fa013cbf	CONFIGURE_TOTP	Configure OTP	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	t	f	CONFIGURE_TOTP	10
96234893-43f1-4cb2-a244-985acdc8efb2	UPDATE_PASSWORD	Update Password	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	t	f	UPDATE_PASSWORD	30
e05f4d3c-59a1-4b29-b6be-9639ad865032	terms_and_conditions	Terms and Conditions	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	f	f	terms_and_conditions	20
426ccd42-6f45-48de-9d8f-9d95266e3c3f	update_user_locale	Update User Locale	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	t	f	update_user_locale	1000
a71fa95b-ec61-4202-9dc4-9fc3c52e75e1	delete_account	Delete Account	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	f	f	delete_account	60
cb21cd17-80b1-4cb3-bd04-74bdaab66cd8	delete_credential	Delete Credential	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	t	f	delete_credential	100
90f0aaa0-5179-464c-bc7c-f64db0cbcce4	VERIFY_EMAIL	Verify Email	test	t	f	VERIFY_EMAIL	50
1f20b148-9297-424c-ac95-a21fab9a98d2	UPDATE_PROFILE	Update Profile	test	t	f	UPDATE_PROFILE	40
5ba26034-af6a-4fb8-969b-f5397e32eb15	CONFIGURE_TOTP	Configure OTP	test	t	f	CONFIGURE_TOTP	10
a528deda-6cb2-48f3-b739-9fc8e3fbfc9e	UPDATE_PASSWORD	Update Password	test	t	f	UPDATE_PASSWORD	30
a94d5907-5f8f-4c7c-9149-380344368d3e	terms_and_conditions	Terms and Conditions	test	f	f	terms_and_conditions	20
5ae78d6e-2959-4dd0-9cf5-efac45bfdebd	update_user_locale	Update User Locale	test	t	f	update_user_locale	1000
c9b6ab79-ff2f-467e-89d3-ce74780f6508	delete_account	Delete Account	test	f	f	delete_account	60
ac479b7b-7425-4284-8a45-b445efe00a69	delete_credential	Delete Credential	test	t	f	delete_credential	100
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
df65ddb1-74e2-4763-9ef8-598d4eea9120	9fe6195e-9708-4aec-a1af-1d3ea5a0e329
02db0790-23bc-49ac-bee0-5fae3c56f316	6028ea4a-d6cc-40f4-ad4c-ba06a65c7293
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
LDAP_ID	amy	cf9e5cad-afc1-4108-b113-b2b5598827ac	15ce49fe-5875-4f17-8bca-3008cddd1b68
LDAP_ENTRY_DN	cn=Amy Wong+sn=Kroker,ou=people,dc=planetexpress,dc=com	cf9e5cad-afc1-4108-b113-b2b5598827ac	121eb60f-0a89-421d-a0cf-2802e53ab9ea
LDAP_ID	bender	9054b8b8-0dad-4620-8afe-770852556d72	9871c7cb-78ea-420b-a070-9b47eb325d8d
LDAP_ENTRY_DN	cn=Bender Bending Rodríguez,ou=people,dc=planetexpress,dc=com	9054b8b8-0dad-4620-8afe-770852556d72	80ebe015-4acc-4c3d-86ac-8ec3e8b8576e
LDAP_ID	fry	cc3c3edf-a9ef-4b80-8302-ae459aaf6f70	b1af8875-da02-46a8-9681-ec6c24ef5fc3
LDAP_ENTRY_DN	cn=Philip J. Fry,ou=people,dc=planetexpress,dc=com	cc3c3edf-a9ef-4b80-8302-ae459aaf6f70	6cd2f925-f5fe-4bbe-8137-3f18d2fe5629
LDAP_ID	hermes	8dc93915-321e-4adc-ad8c-7999dc374995	7f1d3d90-c1f5-46a1-93c0-0774d122583b
LDAP_ENTRY_DN	cn=Hermes Conrad,ou=people,dc=planetexpress,dc=com	8dc93915-321e-4adc-ad8c-7999dc374995	a62c342d-a528-461d-a0d0-1a1cdc6b854e
LDAP_ID	leela	dab8560d-c172-4811-b948-5a147d50adc6	3af85b0c-57c9-4b51-902b-25734f55a11c
LDAP_ENTRY_DN	cn=Turanga Leela,ou=people,dc=planetexpress,dc=com	dab8560d-c172-4811-b948-5a147d50adc6	3da6c3e9-98a8-4bf7-b8a5-f090e6d3ff13
LDAP_ID	professor	492fd916-56d8-4040-9971-6e4333eeb881	af86fcfd-fb45-4d69-85ec-e2fabada0eae
LDAP_ENTRY_DN	cn=Hubert J. Farnsworth,ou=people,dc=planetexpress,dc=com	492fd916-56d8-4040-9971-6e4333eeb881	f4683510-c9dc-4c7d-8b22-031727577350
LDAP_ID	zoidberg	f3c88716-28b9-47fa-b499-63cd30729cdd	d20cbb7a-b2b2-4f7e-87a9-7e823c1d66bd
LDAP_ENTRY_DN	cn=John A. Zoidberg,ou=people,dc=planetexpress,dc=com	f3c88716-28b9-47fa-b499-63cd30729cdd	27668b27-e4b2-4f98-8eae-0138ea9c2976
LDAP_ID	amy	a31869c0-8d57-44f4-93cc-46b2d9f12ca8	7d299f1c-af11-4967-9d31-b38e5cd0a666
LDAP_ENTRY_DN	cn=Amy Wong+sn=Kroker,ou=people,dc=planetexpress,dc=com	a31869c0-8d57-44f4-93cc-46b2d9f12ca8	8026caab-68f5-4c31-b20f-643dd356a73a
LDAP_ID	bender	62f817d4-1aaa-43a9-8d04-deb9a638afed	3fbc087a-c1ee-49c4-a115-7f5231c6db69
LDAP_ENTRY_DN	cn=Bender Bending Rodríguez,ou=people,dc=planetexpress,dc=com	62f817d4-1aaa-43a9-8d04-deb9a638afed	836713aa-b9ab-49c9-a903-0bb007098cf0
LDAP_ID	fry	a629a159-d6d8-45f5-ae03-727800f34db0	c42f11cd-888a-4a43-99b9-edf630fd1887
LDAP_ENTRY_DN	cn=Philip J. Fry,ou=people,dc=planetexpress,dc=com	a629a159-d6d8-45f5-ae03-727800f34db0	8089e312-f386-4db3-9b20-b881610214bd
LDAP_ID	hermes	f99e74fb-347f-40b9-a340-d30f10205904	42798459-857b-4e05-915a-e5db3d8dc095
LDAP_ENTRY_DN	cn=Hermes Conrad,ou=people,dc=planetexpress,dc=com	f99e74fb-347f-40b9-a340-d30f10205904	3b47af3f-6d9d-4597-aaa3-529a6c3f8bbc
LDAP_ID	leela	398c18ad-9307-499f-ac03-83a0f4c5e59a	b839dfd2-09a0-448d-ae05-c07203f8b83e
LDAP_ENTRY_DN	cn=Turanga Leela,ou=people,dc=planetexpress,dc=com	398c18ad-9307-499f-ac03-83a0f4c5e59a	c8d21aa3-a7f6-44ab-85cc-7356597e2e8e
LDAP_ID	professor	e666f2f8-5ad0-4b0d-9a4a-de379df8379f	1ce6f5a5-c81d-40d3-8c76-7c135d41fc33
LDAP_ENTRY_DN	cn=Hubert J. Farnsworth,ou=people,dc=planetexpress,dc=com	e666f2f8-5ad0-4b0d-9a4a-de379df8379f	26c89bad-2a00-4ce1-97f5-6267c0180a07
LDAP_ID	zoidberg	a11a3de6-fdbb-4634-9d90-f1d5e42f667c	4bd6f663-1454-47e3-b075-def4e74f7d71
LDAP_ENTRY_DN	cn=John A. Zoidberg,ou=people,dc=planetexpress,dc=com	a11a3de6-fdbb-4634-9d90-f1d5e42f667c	14387733-0967-42e4-bc76-0055b9f07981
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
636228eb-9869-4c9a-a74d-1848b4741a7d	\N	23e723db-b84d-441a-9d8a-b00f47e3c326	f	t	\N	\N	\N	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	admin	1713461798143	\N	0
e666f2f8-5ad0-4b0d-9a4a-de379df8379f	professor@planetexpress.com	professor@planetexpress.com	f	t	20ff871b-1d24-4312-b7e4-14084d8b8594	Hubert	Farnsworth	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	hubert j. farnsworth	1713465028236	\N	0
cf9e5cad-afc1-4108-b113-b2b5598827ac	amy@planetexpress.com	amy@planetexpress.com	f	t	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	Amy	Kroker	test	amy wong	1713464990190	\N	0
9054b8b8-0dad-4620-8afe-770852556d72	bender@planetexpress.com	bender@planetexpress.com	f	t	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	Bender	Rodríguez	test	bender bending rodríguez	1713464990217	\N	0
cc3c3edf-a9ef-4b80-8302-ae459aaf6f70	fry@planetexpress.com	fry@planetexpress.com	f	t	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	Philip	Fry	test	philip j. fry	1713464990233	\N	0
a11a3de6-fdbb-4634-9d90-f1d5e42f667c	zoidberg@planetexpress.com	zoidberg@planetexpress.com	f	t	20ff871b-1d24-4312-b7e4-14084d8b8594	John	Zoidberg	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	john a. zoidberg	1713465028249	\N	0
8dc93915-321e-4adc-ad8c-7999dc374995	hermes@planetexpress.com	hermes@planetexpress.com	f	t	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	Hermes	Conrad	test	hermes conrad	1713464990247	\N	0
dab8560d-c172-4811-b948-5a147d50adc6	leela@planetexpress.com	leela@planetexpress.com	f	t	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	Leela	Turanga	test	turanga leela	1713464990262	\N	0
492fd916-56d8-4040-9971-6e4333eeb881	professor@planetexpress.com	professor@planetexpress.com	f	t	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	Hubert	Farnsworth	test	hubert j. farnsworth	1713464990276	\N	0
f3c88716-28b9-47fa-b499-63cd30729cdd	zoidberg@planetexpress.com	zoidberg@planetexpress.com	f	t	ec0594c8-4a49-4d2f-81cd-107ed96ea5fa	John	Zoidberg	test	john a. zoidberg	1713464990292	\N	0
a31869c0-8d57-44f4-93cc-46b2d9f12ca8	amy@planetexpress.com	amy@planetexpress.com	f	t	20ff871b-1d24-4312-b7e4-14084d8b8594	Amy	Kroker	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	amy wong	1713465028150	\N	0
62f817d4-1aaa-43a9-8d04-deb9a638afed	bender@planetexpress.com	bender@planetexpress.com	f	t	20ff871b-1d24-4312-b7e4-14084d8b8594	Bender	Rodríguez	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	bender bending rodríguez	1713465028178	\N	0
a629a159-d6d8-45f5-ae03-727800f34db0	fry@planetexpress.com	fry@planetexpress.com	f	t	20ff871b-1d24-4312-b7e4-14084d8b8594	Philip	Fry	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	philip j. fry	1713465028194	\N	0
f99e74fb-347f-40b9-a340-d30f10205904	hermes@planetexpress.com	hermes@planetexpress.com	f	t	20ff871b-1d24-4312-b7e4-14084d8b8594	Hermes	Conrad	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	hermes conrad	1713465028208	\N	0
398c18ad-9307-499f-ac03-83a0f4c5e59a	leela@planetexpress.com	leela@planetexpress.com	f	t	20ff871b-1d24-4312-b7e4-14084d8b8594	Leela	Turanga	d0cc31c9-0c5d-4f9e-820f-29e5cc19af45	turanga leela	1713465028222	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
d1d03d49-5085-4e4d-9bba-80da7ec478e2	636228eb-9869-4c9a-a74d-1848b4741a7d
692ff45c-c18a-4f35-b9cd-076ed09f5133	636228eb-9869-4c9a-a74d-1848b4741a7d
05e60180-0ff5-4bf4-9eef-5b6cc6b970bc	636228eb-9869-4c9a-a74d-1848b4741a7d
d4194e70-2276-430d-9d56-4395535e0d13	636228eb-9869-4c9a-a74d-1848b4741a7d
376ba33f-7934-41d0-a53d-f08d218a07db	636228eb-9869-4c9a-a74d-1848b4741a7d
e0b5492f-c5c0-4ce8-87c3-40426f88dc4f	636228eb-9869-4c9a-a74d-1848b4741a7d
371c369f-a6e5-44a5-9f48-f9e580771107	636228eb-9869-4c9a-a74d-1848b4741a7d
61c937b9-8c11-4e5d-b287-4d36f50bc147	636228eb-9869-4c9a-a74d-1848b4741a7d
10daa0cb-9513-43a4-8fab-b69284909058	636228eb-9869-4c9a-a74d-1848b4741a7d
3723d33d-9647-478d-a60e-78228cdeb91d	636228eb-9869-4c9a-a74d-1848b4741a7d
cf20a14f-7f36-47e1-9082-f02d646c1725	636228eb-9869-4c9a-a74d-1848b4741a7d
fd0a3875-df3d-4808-9876-85def46e4720	636228eb-9869-4c9a-a74d-1848b4741a7d
3c45d12c-0daf-4690-af59-6153fe38b68a	636228eb-9869-4c9a-a74d-1848b4741a7d
d5d2450d-382b-4af6-9909-bffdc43009c1	636228eb-9869-4c9a-a74d-1848b4741a7d
ab18ae86-8b38-49ed-9da0-0d0d36c9998d	636228eb-9869-4c9a-a74d-1848b4741a7d
bebb48d8-c24c-4620-9763-391d1716fcec	636228eb-9869-4c9a-a74d-1848b4741a7d
7e9a9599-3433-44ec-974f-9bb087ce76fb	636228eb-9869-4c9a-a74d-1848b4741a7d
89e1ada2-0640-426e-bfa7-9278723991a4	636228eb-9869-4c9a-a74d-1848b4741a7d
efb7bdce-616e-48a6-bb0d-1ef1a5a66ceb	636228eb-9869-4c9a-a74d-1848b4741a7d
450c5b8b-dfb6-432a-a184-9b472ef77f86	cf9e5cad-afc1-4108-b113-b2b5598827ac
450c5b8b-dfb6-432a-a184-9b472ef77f86	9054b8b8-0dad-4620-8afe-770852556d72
450c5b8b-dfb6-432a-a184-9b472ef77f86	cc3c3edf-a9ef-4b80-8302-ae459aaf6f70
450c5b8b-dfb6-432a-a184-9b472ef77f86	8dc93915-321e-4adc-ad8c-7999dc374995
450c5b8b-dfb6-432a-a184-9b472ef77f86	dab8560d-c172-4811-b948-5a147d50adc6
450c5b8b-dfb6-432a-a184-9b472ef77f86	492fd916-56d8-4040-9971-6e4333eeb881
450c5b8b-dfb6-432a-a184-9b472ef77f86	f3c88716-28b9-47fa-b499-63cd30729cdd
d1d03d49-5085-4e4d-9bba-80da7ec478e2	a31869c0-8d57-44f4-93cc-46b2d9f12ca8
d1d03d49-5085-4e4d-9bba-80da7ec478e2	62f817d4-1aaa-43a9-8d04-deb9a638afed
d1d03d49-5085-4e4d-9bba-80da7ec478e2	a629a159-d6d8-45f5-ae03-727800f34db0
d1d03d49-5085-4e4d-9bba-80da7ec478e2	f99e74fb-347f-40b9-a340-d30f10205904
d1d03d49-5085-4e4d-9bba-80da7ec478e2	398c18ad-9307-499f-ac03-83a0f4c5e59a
d1d03d49-5085-4e4d-9bba-80da7ec478e2	e666f2f8-5ad0-4b0d-9a4a-de379df8379f
d1d03d49-5085-4e4d-9bba-80da7ec478e2	a11a3de6-fdbb-4634-9d90-f1d5e42f667c
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
e48a8fee-4299-444c-915b-f68d37bbf1fd	+
5a3f72bf-aacd-4096-b3fb-4065b7f31083	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: oskeycloak0jbosststxtable oskeycloak0jbosststxtable_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.oskeycloak0jbosststxtable
    ADD CONSTRAINT oskeycloak0jbosststxtable_pkey PRIMARY KEY (uidstring, typename, statetype);


--
-- Name: oskeycloak1jbosststxtable oskeycloak1jbosststxtable_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.oskeycloak1jbosststxtable
    ADD CONSTRAINT oskeycloak1jbosststxtable_pkey PRIMARY KEY (uidstring, typename, statetype);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

