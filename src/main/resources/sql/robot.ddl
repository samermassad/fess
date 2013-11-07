DROP TABLE IF EXISTS URL_FILTER;
DROP TABLE IF EXISTS ACCESS_RESULT_DATA;
DROP TABLE IF EXISTS ACCESS_RESULT;
DROP TABLE IF EXISTS URL_QUEUE;

/**********************************/
/* Table Name: URL Queue */
/**********************************/
CREATE TABLE URL_QUEUE(
  ID IDENTITY NOT NULL PRIMARY KEY,
  SESSION_ID VARCHAR(20) NOT NULL,
  METHOD VARCHAR(10) NOT NULL,
  URL VARCHAR(65536) NOT NULL,
  ENCODING VARCHAR(20),
  PARENT_URL VARCHAR(65536),
  DEPTH INTEGER NOT NULL,
  LAST_MODIFIED TIMESTAMP,
  CREATE_TIME TIMESTAMP NOT NULL
);

/**********************************/
/* Table Name: Access Result */
/**********************************/
CREATE TABLE ACCESS_RESULT(
  ID IDENTITY NOT NULL PRIMARY KEY,
  SESSION_ID VARCHAR(20) NOT NULL,
  RULE_ID VARCHAR(20),
  URL VARCHAR(65536) NOT NULL,
  PARENT_URL VARCHAR(65536),
  STATUS INTEGER NOT NULL,
  HTTP_STATUS_CODE INTEGER NOT NULL,
  METHOD VARCHAR(10) NOT NULL,
  MIME_TYPE VARCHAR(100) NOT NULL,
  CONTENT_LENGTH BIGINT NOT NULL,
  EXECUTION_TIME INTEGER NOT NULL,
  LAST_MODIFIED TIMESTAMP NOT NULL,
  CREATE_TIME TIMESTAMP NOT NULL
);

/**********************************/
/* Table Name: Access Result Data */
/**********************************/
CREATE TABLE ACCESS_RESULT_DATA(
  ID BIGINT(20) NOT NULL PRIMARY KEY,
  TRANSFORMER_NAME VARCHAR(255) NOT NULL,
  DATA BLOB,
  ENCODING VARCHAR(20),
  FOREIGN KEY (ID) REFERENCES ACCESS_RESULT (ID)
);

/**********************************/
/* Table Name: URL Filter */
/**********************************/
CREATE TABLE URL_FILTER(
  ID IDENTITY NOT NULL PRIMARY KEY,
  SESSION_ID VARCHAR(20) NOT NULL,
  URL VARCHAR(65536) NOT NULL,
  FILTER_TYPE VARCHAR(1) NOT NULL,
  CREATE_TIME TIMESTAMP NOT NULL
);


CREATE INDEX IDX_URL_QUEUE_SESSION_ID_AND_TIME ON URL_QUEUE (SESSION_ID, CREATE_TIME);
CREATE INDEX IDX_URL_QUEUE_SESSION_ID_AND_URL ON URL_QUEUE (SESSION_ID, URL);
CREATE INDEX IDX_URL_QUEUE_SESSION_ID ON URL_QUEUE (SESSION_ID);

CREATE INDEX IDX_ACCESS_RESULT_SESSION_ID_AND_TIME ON ACCESS_RESULT (SESSION_ID, CREATE_TIME);
CREATE INDEX IDX_ACCESS_RESULT_SESSION_ID_AND_URL ON ACCESS_RESULT (SESSION_ID, URL);
CREATE INDEX IDX_ACCESS_RESULT_SESSION_ID ON ACCESS_RESULT (SESSION_ID);
CREATE INDEX IDX_ACCESS_RESULT_URL_AND_TIME ON ACCESS_RESULT (URL, CREATE_TIME);

CREATE INDEX IDX_URL_FILTER_SESSION_ID_AND_FILTER_TYPE ON URL_FILTER (SESSION_ID, FILTER_TYPE);

