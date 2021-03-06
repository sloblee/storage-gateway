/**********************************************
* Copyright (c) 2016 Huawei Technologies Co., Ltd. All rights reserved.
* 
* File name:    log.h
* Author: 
* Date:         2016/07/11
* Version:      1.0
* Description:
* 
**********************************************/
#ifndef LOG_H_
#define LOG_H_
#include <boost/log/sources/logger.hpp>
#include <boost/log/attributes/named_scope.hpp>
#include <boost/log/common.hpp>
#include <string>
#define LOG_PATH "/var/log/dr_service"
// define severity levels
typedef enum severity_level
{
    trace,
    debug,
    info,
    warning,
    error,
    fatal
}severity_level_t;

extern std::string path_to_filename(std::string path);
extern std::string set_get_attrib(const char* name, std::string value);
extern int set_get_attrib(const char* name, int value);
class DRLog{
public:
    static ::boost::log::sources::severity_logger<severity_level> slg;
    static void log_init(std::string file_name); // set log file name
    static void set_log_level(severity_level_t level);
};

#define BOOST_SLOG(log_level) \
    BOOST_LOG_STREAM_WITH_PARAMS( \
        (DRLog::slg), \
        (set_get_attrib("File", path_to_filename(__FILE__))) \
        (set_get_attrib("Line", __LINE__)) \
        (::boost::log::keywords::severity = log_level) \
    )

#define LOG_FATAL BOOST_SLOG(fatal)
#define LOG_ERROR BOOST_SLOG(error)
#define LOG_WARN BOOST_SLOG(warning)
#define LOG_INFO BOOST_SLOG(info)
#define LOG_DEBUG BOOST_SLOG(debug)
#define LOG_TRACE BOOST_SLOG(trace)

#define SHOW_CALL_STACK BOOST_LOG_FUNCTION()
#define SET_ACOPE_NAME(name) BOOST_LOG_NAMED_SCOPE(name)
#endif
