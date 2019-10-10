CREATE TABLE t_matview_ao (id int NOT NULL PRIMARY KEY, type text NOT NULL, amt numeric NOT NULL);
INSERT INTO t_matview_ao VALUES
  (1, 'x', 2),
  (2, 'x', 3),
  (3, 'y', 5),
  (4, 'y', 7),
  (5, 'z', 11);

CREATE MATERIALIZED VIEW m_heap AS SELECT type, sum(amt) AS totamt FROM t_matview_ao GROUP BY type WITH NO DATA distributed by(type);
CREATE UNIQUE INDEX m_heap_index ON m_heap(type);
SELECT * from m_heap;
REFRESH MATERIALIZED VIEW CONCURRENTLY m_heap;
REFRESH MATERIALIZED VIEW m_heap;
SELECT * FROM m_heap;
REFRESH MATERIALIZED VIEW CONCURRENTLY m_heap;
SELECT * FROM m_heap;

CREATE MATERIALIZED VIEW m_ao with (appendonly=true) AS SELECT type, sum(amt) AS totamt FROM t_matview_ao GROUP BY type WITH NO DATA  distributed by(type);
SELECT * from m_ao;
REFRESH MATERIALIZED VIEW m_ao;
SELECT * FROM m_ao;

CREATE MATERIALIZED VIEW m_aocs with (appendonly=true, orientation=column) AS SELECT type, sum(amt) AS totamt FROM t_matview_ao GROUP BY type WITH NO DATA  distributed by(type);
SELECT * from m_aocs;
REFRESH MATERIALIZED VIEW m_aocs;
SELECT * FROM m_aocs;

