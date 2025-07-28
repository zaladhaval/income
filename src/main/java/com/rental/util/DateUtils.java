package com.rental.util;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

/**
 * Utility class for date formatting and conversion
 * Used primarily for JSP pages to handle timestamp to date conversions
 */
public class DateUtils {
    
    private static final ZoneId DEFAULT_ZONE = ZoneId.systemDefault();
    
    // Common date formatters
    public static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("MMM dd, yyyy");
    public static final DateTimeFormatter DATETIME_FORMATTER = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
    public static final DateTimeFormatter SHORT_DATE_FORMATTER = DateTimeFormatter.ofPattern("MM/dd/yyyy");
    
    /**
     * Convert timestamp (milliseconds) to Date object for JSP formatting
     */
    public static Date timestampToDate(long timestamp) {
        if (timestamp == 0) {
            return null;
        }
        return new Date(timestamp);
    }
    
    /**
     * Convert timestamp to LocalDate
     */
    public static LocalDate timestampToLocalDate(long timestamp) {
        if (timestamp == 0) {
            return null;
        }
        return Instant.ofEpochMilli(timestamp).atZone(DEFAULT_ZONE).toLocalDate();
    }
    
    /**
     * Convert timestamp to LocalDateTime
     */
    public static LocalDateTime timestampToLocalDateTime(long timestamp) {
        if (timestamp == 0) {
            return null;
        }
        return Instant.ofEpochMilli(timestamp).atZone(DEFAULT_ZONE).toLocalDateTime();
    }

    /**
     * Format timestamp to short date string (yyyy-MM-dd) for HTML date inputs
     */
    public static String formatShortDate(long timestamp) {
        if (timestamp == 0) return "";
        LocalDate date = timestampToLocalDate(timestamp);
        return date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }
    
    /**
     * Format timestamp as date string
     */
    public static String formatDate(long timestamp) {
        if (timestamp == 0) {
            return "N/A";
        }
        LocalDate date = timestampToLocalDate(timestamp);
        return date.format(DATE_FORMATTER);
    }
    
    /**
     * Format timestamp as datetime string
     */
    public static String formatDateTime(long timestamp) {
        if (timestamp == 0) {
            return "N/A";
        }
        LocalDateTime dateTime = timestampToLocalDateTime(timestamp);
        return dateTime.format(DATETIME_FORMATTER);
    }
    

    
    /**
     * Convert LocalDate to timestamp
     */
    public static long localDateToTimestamp(LocalDate localDate) {
        if (localDate == null) {
            return 0;
        }
        return localDate.atStartOfDay(DEFAULT_ZONE).toInstant().toEpochMilli();
    }
    
    /**
     * Convert LocalDateTime to timestamp
     */
    public static long localDateTimeToTimestamp(LocalDateTime localDateTime) {
        if (localDateTime == null) {
            return 0;
        }
        return localDateTime.atZone(DEFAULT_ZONE).toInstant().toEpochMilli();
    }
    
    /**
     * Check if timestamp represents a valid date (not zero)
     */
    public static boolean isValidTimestamp(long timestamp) {
        return timestamp > 0;
    }
}
