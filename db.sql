-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 09, 2020 lúc 09:24 AM
-- Phiên bản máy phục vụ: 10.1.34-MariaDB
-- Phiên bản PHP: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `smartfarming`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nhat_ky_hoat_dong_cua_nguoi_dung` ACTION=0 la tat, ACTION=1 la bat
--
CREATE TABLE `nhat_ky_hoat_dong_cua_nguoi_dung` (
  `ACTION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ACTION_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `USER_ID` int(11) NOT NULL,
  `DEVICE_ID` int(11) NOT NULL,
  `ACTION` bit(1) NOT NULL, 
  PRIMARY KEY(`ACTION_ID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Cấu trúc bảng cho bảng `cac_nong_trai`
--
CREATE TABLE `cac_nong_trai` (
  `FARM_ID` int(11) NOT NULL AUTO_INCREMENT,
  `FARM_NAME` varchar(40) NOT NULL,
  `FARM_DESCRIPTION` varchar(255),
  PRIMARY KEY(FARM_ID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Cấu trúc bảng cho bảng `cac_hoat_dong`
--

CREATE TABLE `cac_hoat_dong` (
  `USER_ID` int(11) NOT NULL,
  `SCHEDULE_ID` int(11) NOT NULL,
  `SCHEDULE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ACTIVITY_ID` int(11) NOT NULL,
  `DEVICE_ID` int(11) NOT NULL,
  `DEVICE_STATE` bit(1) NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime NOT NULL,
  `ACTIVITY_DESCRIPTION` varchar(255),
  PRIMARY KEY (`USER_ID`,`SCHEDULE_ID`,`SCHEDULE_TIME`,`ACTIVITY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `du_lieu_tu_moi_truong`
--

CREATE TABLE `du_lieu_tu_moi_truong` (
  `SENSOR_ID` int(11) NOT NULL,
  `COLLECT_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DATA` float NOT NULL,
  `DATA_UNIT` varchar(10) NOT NULL,
  PRIMARY KEY (`SENSOR_ID`,`COLLECT_TIME`,`DATA_UNIT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Cấu trúc bảng cho bảng `lich_hoat_dong_do_nguoi_dung_dat`
--

CREATE TABLE `lich_hoat_dong_do_nguoi_dung_dat` (
  `USER_ID` int(11) NOT NULL,
  `SCHEDULE_ID` int(11) NOT NULL,
  `SCHEDULE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TIME_START` datetime NOT NULL,
  `TIME_END` datetime NOT NULL,
  PRIMARY KEY (`USER_ID`,`SCHEDULE_ID`,`SCHEDULE_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguoi_dung`
--

CREATE TABLE `nguoi_dung` (
  `USER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NAME` varchar(30) NOT NULL,
  `FULL_NAME` varchar(60) NOT NULL,
  `PASSWORD` varchar(60) NOT NULL,
  `IDGROUP` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Cấu trúc bảng cho bảng `thiet_bi_input_sensors`
--

CREATE TABLE `cac_thiet_bi` (
  `DEVICE_ID` int(11) NOT NULL ,
  `DEVICE_NAME` varchar(40) NOT NULL,
  `DEVICE_TYPE` varchar(10) NOT NULL,
  `FARM_ID` int(11) NOT NULL,
  `LONGITUDE` float NOT NULL,
  `LATITUDE` float NOT NULL,
  PRIMARY KEY (`DEVICE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Cấu trúc bảng cho bảng `thong_so_nguong`
--

CREATE TABLE `thong_so_nguong` (
  `LEVEL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `FARM_ID` int(11) NOT NULL,
  `LEVEL_NAME` varchar(40) NOT NULL,
  `LEVEL_THRESHOLE` float NOT NULL,
  `LEVEL_UNIT` varchar(10) NOT NULL,
  PRIMARY KEY (`LEVEL_ID`, `FARM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `trang_thai_hoat_dong`
--

CREATE TABLE `trang_thai_hoat_dong` (
  `ACTUATOR_ID` int(11) NOT NULL,
  `TIME` datetime NOT NULL,
  `STATE` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ACTUATOR_ID`,`TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Các ràng buộc cho bảng `cac_hoat_dong`
--
ALTER TABLE `cac_hoat_dong`
  ADD CONSTRAINT `cac_hoat_dong_ibfk_1` FOREIGN KEY (`USER_ID`,`SCHEDULE_ID`,`SCHEDULE_TIME`) REFERENCES `lich_hoat_dong_do_nguoi_dung_dat` (`USER_ID`, `SCHEDULE_ID`, `SCHEDULE_TIME`),
  ADD CONSTRAINT `cac_hoat_dong_ibfk_2` FOREIGN KEY (`DEVICE_ID`) REFERENCES `cac_thiet_bi` (`DEVICE_ID`);
--
-- Các ràng buộc cho bảng `du_lieu_tu_moi_truong`
--
ALTER TABLE `du_lieu_tu_moi_truong`
  ADD CONSTRAINT `du_lieu_tu_moi_truong_ibfk_1` FOREIGN KEY (`SENSOR_ID`) REFERENCES `cac_thiet_bi` (`DEVICE_ID`);

--
-- Các ràng buộc cho bảng `lich_hoat_dong_do_nguoi_dung_dat`
--
ALTER TABLE `lich_hoat_dong_do_nguoi_dung_dat`
  ADD CONSTRAINT `lich_hoat_dong_do_nguoi_dung_dat_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `nguoi_dung` (`USER_ID`);

--
-- Các ràng buộc cho bảng `trang_thai_hoat_dong`
--
ALTER TABLE `trang_thai_hoat_dong`
  ADD CONSTRAINT `trang_thai_hoat_dong_ibfk_1` FOREIGN KEY (`ACTUATOR_ID`) REFERENCES `cac_thiet_bi` (`DEVICE_ID`);

ALTER TABLE `cac_thiet_bi`
  ADD CONSTRAINT `cac_thiet_bi_ibfk_1` FOREIGN KEY (`FARM_ID`) REFERENCES `cac_nong_trai` (`FARM_ID`);

ALTER TABLE `thong_so_nguong`
  ADD CONSTRAINT `thong_so_nguong_ibfk_1` FOREIGN KEY (`FARM_ID`) REFERENCES `cac_nong_trai` (`FARM_ID`);

ALTER TABLE `nhat_ky_hoat_dong_cua_nguoi_dung`
  ADD CONSTRAINT `nhat_ky_hoat_dong_cua_nguoi_dung_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `nguoi_dung` (`USER_ID`),
  ADD CONSTRAINT `nhat_ky_hoat_dong_cua_nguoi_dung_ibfk_2` FOREIGN KEY (`DEVICE_ID`) REFERENCES `cac_thiet_bi` (`DEVICE_ID`);

  
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
