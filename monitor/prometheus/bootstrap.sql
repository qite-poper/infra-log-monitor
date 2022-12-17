CREATE TABLE Model (
    ID INTEGER UNIQUE DEFAULT(1),
    version VARCHAR(20) NOT NULL,
    CONSTRAINT single_row CHECK (ID = 1)
);

INSERT INTO Model (version) VALUES ('0.0.1');

-- Create the rest of the tables
CREATE TABLE AlertGroup (
        ID SERIAL NOT NULL PRIMARY KEY,
        time TIMESTAMP NOT NULL,
        receiver VARCHAR(100) NOT NULL,
        status VARCHAR(50) NOT NULL,
        externalURL TEXT NOT NULL,
        groupKey VARCHAR(255) NOT NULL
);

CREATE INDEX ON AlertGroup (time);

CREATE INDEX ON AlertGroup (status, time);

CREATE TABLE GroupLabel (
    ID SERIAL NOT NULL PRIMARY KEY,
    AlertGroupID INT NOT NULL references AlertGroup(ID),
    GroupLabel VARCHAR(100) NOT NULL,
    Value VARCHAR(1000) NOT NULL
);

CREATE TABLE CommonLabel (
        ID SERIAL NOT NULL PRIMARY KEY,
    AlertGroupID INT NOT NULL references AlertGroup (ID),
    Label VARCHAR(100) NOT NULL,
    Value VARCHAR(1000) NOT NULL
);

CREATE TABLE CommonAnnotation (
        ID SERIAL NOT NULL PRIMARY KEY,
    AlertGroupID INT NOT NULL REFERENCES AlertGroup (ID),
    Annotation VARCHAR(100) NOT NULL,
    Value VARCHAR(1000) NOT NULL
);

CREATE TABLE Alert (
        ID SERIAL NOT NULL PRIMARY KEY,
    alertGroupID INT NOT NULL REFERENCES AlertGroup (ID),
        status VARCHAR(50) NOT NULL,
    startsAt TIMESTAMP NOT NULL,
    endsAt TIMESTAMP NULL,
        generatorURL TEXT NOT NULL
);

CREATE TABLE AlertLabel (
        ID SERIAL NOT NULL PRIMARY KEY,
    AlertID INT NOT NULL REFERENCES Alert (ID),
    Label VARCHAR(100) NOT NULL,
    Value VARCHAR(10000) NOT NULL
);

CREATE TABLE AlertAnnotation (
        ID SERIAL NOT NULL PRIMARY KEY,
    AlertID INT NOT NULL REFERENCES Alert (ID),
    Annotation VARCHAR(100) NOT NULL,
    Value VARCHAR(10000) NOT NULL
);
