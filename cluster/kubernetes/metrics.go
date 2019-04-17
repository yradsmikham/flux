package kubernetes

import (
	"github.com/go-kit/kit/metrics/prometheus"
	stdprometheus "github.com/prometheus/client_golang/prometheus"
)

var (
	fluxFailures = prometheus.NewCounterFrom(stdprometheus.CounterOpts{
		Namespace: "flux",
		Subsystem: "kubernetes",
		Name:      "flux_kubcetl_apply_failures",
		Help:      "Counter that depicts the number of failures that have occurred",
	}, []string{})
)
