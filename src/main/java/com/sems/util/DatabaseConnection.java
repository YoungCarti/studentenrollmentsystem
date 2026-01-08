package com.sems.util;

import com.sems.exception.DatabaseException;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Database connection manager using HikariCP connection pooling.
 * Implements Singleton pattern to ensure single data source instance.
 * 
 * @author SEMS Team
 * @version 1.0
 */
public class DatabaseConnection {
    
    private static final Logger LOGGER = Logger.getLogger(DatabaseConnection.class.getName());
    private static HikariDataSource dataSource;
    private static DatabaseConnection instance;
    
    /**
     * Private constructor to enforce Singleton pattern
     * Initializes the HikariCP connection pool
     */
    private DatabaseConnection() throws DatabaseException {
        try {
            Properties props = loadProperties();
            HikariConfig config = new HikariConfig();
            
            // Database connection properties
            config.setJdbcUrl(props.getProperty("db.url"));
            config.setUsername(props.getProperty("db.username"));
            config.setPassword(props.getProperty("db.password"));
            config.setDriverClassName(props.getProperty("db.driver"));
            
            // Connection pool properties
            config.setMaximumPoolSize(Integer.parseInt(props.getProperty("db.pool.size", "10")));
            config.setMaxLifetime(Long.parseLong(props.getProperty("db.pool.maxLifetime", "1800000")));
            config.setConnectionTimeout(Long.parseLong(props.getProperty("db.pool.connectionTimeout", "30000")));
            
            // Connection pool optimization
            config.setAutoCommit(true);
            config.setConnectionTestQuery("SELECT 1");
            config.addDataSourceProperty("cachePrepStmts", "true");
            config.addDataSourceProperty("prepStmtCacheSize", "250");
            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
            
            dataSource = new HikariDataSource(config);
            
            LOGGER.info("Database connection pool initialized successfully");
            
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Failed to load database properties", e);
            throw new DatabaseException("Failed to load database configuration", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to initialize connection pool", e);
            throw new DatabaseException("Failed to initialize database connection pool", e);
        }
    }
    
    /**
     * Load database properties from file
     * 
     * @return Properties object with database configuration
     * @throws IOException if properties file cannot be read
     */
    private Properties loadProperties() throws IOException {
        Properties props = new Properties();
        try (InputStream input = getClass().getClassLoader()
                .getResourceAsStream("database.properties")) {
            
            if (input == null) {
                throw new IOException("Unable to find database.properties");
            }
            
            props.load(input);
        }
        return props;
    }
    
    /**
     * Get singleton instance of DatabaseConnection
     * 
     * @return DatabaseConnection instance
     * @throws DatabaseException if initialization fails
     */
    public static synchronized DatabaseConnection getInstance() throws DatabaseException {
        if (instance == null) {
            instance = new DatabaseConnection();
        }
        return instance;
    }
    
    /**
     * Get a connection from the pool
     * 
     * @return Database connection
     * @throws DatabaseException if connection cannot be obtained
     */
    public static Connection getConnection() throws DatabaseException {
        try {
            if (dataSource == null) {
                getInstance();
            }
            
            Connection conn = dataSource.getConnection();
            
            if (conn == null) {
                throw new DatabaseException("Failed to obtain database connection from pool");
            }
            
            return conn;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting database connection", e);
            throw new DatabaseException("Failed to get database connection", e);
        }
    }
    
    /**
     * Close a database connection (returns it to the pool)
     * 
     * @param conn Connection to close
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                LOGGER.fine("Connection returned to pool");
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error closing database connection", e);
            }
        }
    }
    
    /**
     * Shutdown the connection pool
     * Should be called when application is shutting down
     */
    public static void shutdown() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            LOGGER.info("Database connection pool shut down successfully");
        }
    }
    
    /**
     * Test database connectivity
     * 
     * @return true if connection is successful, false otherwise
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Database connection test failed", e);
            return false;
        }
    }
    
    /**
     * Get connection pool statistics
     * 
     * @return String with pool statistics
     */
    public static String getPoolStats() {
        if (dataSource != null) {
            return String.format("Active: %d, Idle: %d, Total: %d, Waiting: %d",
                    dataSource.getHikariPoolMXBean().getActiveConnections(),
                    dataSource.getHikariPoolMXBean().getIdleConnections(),
                    dataSource.getHikariPoolMXBean().getTotalConnections(),
                    dataSource.getHikariPoolMXBean().getThreadsAwaitingConnection());
        }
        return "Pool not initialized";
    }
}
