# syntax = docker/dockerfile:1.4.0

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt install --no-install-recommends -y \
        e2tools \
        libarchive-tools

