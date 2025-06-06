// Code generated by depstubber. DO NOT EDIT.
// This is a simple stub for github.com/rqlite/gorqlite, strictly for use in testing.

// See the LICENSE file for information about the licensing of the original library.
// Source: github.com/rqlite/gorqlite (exports: Connection,ParameterizedStatement; functions: Open)

// Package gorqlite is a stub of github.com/rqlite/gorqlite, generated by depstubber.
package gorqlite

import (
	context "context"
)

type Connection struct {
	ID string
}

func (_ *Connection) Close() {}

func (_ *Connection) ConsistencyLevel() (string, error) {
	return "", nil
}

func (_ *Connection) Leader() (string, error) {
	return "", nil
}

func (_ *Connection) Peers() ([]string, error) {
	return nil, nil
}

func (_ *Connection) Query(_ []string) ([]QueryResult, error) {
	return nil, nil
}

func (_ *Connection) QueryContext(_ context.Context, _ []string) ([]QueryResult, error) {
	return nil, nil
}

func (_ *Connection) QueryOne(_ string) (QueryResult, error) {
	return QueryResult{}, nil
}

func (_ *Connection) QueryOneContext(_ context.Context, _ string) (QueryResult, error) {
	return QueryResult{}, nil
}

func (_ *Connection) QueryOneParameterized(_ ParameterizedStatement) (QueryResult, error) {
	return QueryResult{}, nil
}

func (_ *Connection) QueryOneParameterizedContext(_ context.Context, _ ParameterizedStatement) (QueryResult, error) {
	return QueryResult{}, nil
}

func (_ *Connection) QueryParameterized(_ []ParameterizedStatement) ([]QueryResult, error) {
	return nil, nil
}

func (_ *Connection) QueryParameterizedContext(_ context.Context, _ []ParameterizedStatement) ([]QueryResult, error) {
	return nil, nil
}

func (_ *Connection) Queue(_ []string) (int64, error) {
	return 0, nil
}

func (_ *Connection) QueueContext(_ context.Context, _ []string) (int64, error) {
	return 0, nil
}

func (_ *Connection) QueueOne(_ string) (int64, error) {
	return 0, nil
}

func (_ *Connection) QueueOneContext(_ context.Context, _ string) (int64, error) {
	return 0, nil
}

func (_ *Connection) QueueOneParameterized(_ ParameterizedStatement) (int64, error) {
	return 0, nil
}

func (_ *Connection) QueueOneParameterizedContext(_ context.Context, _ ParameterizedStatement) (int64, error) {
	return 0, nil
}

func (_ *Connection) QueueParameterized(_ []ParameterizedStatement) (int64, error) {
	return 0, nil
}

func (_ *Connection) QueueParameterizedContext(_ context.Context, _ []ParameterizedStatement) (int64, error) {
	return 0, nil
}

func (_ *Connection) Request(_ []string) ([]RequestResult, error) {
	return nil, nil
}

func (_ *Connection) RequestContext(_ context.Context, _ []string) ([]RequestResult, error) {
	return nil, nil
}

func (_ *Connection) RequestParameterized(_ []ParameterizedStatement) ([]RequestResult, error) {
	return nil, nil
}

func (_ *Connection) RequestParameterizedContext(_ context.Context, _ []ParameterizedStatement) ([]RequestResult, error) {
	return nil, nil
}

func (_ *Connection) SetConsistencyLevel(_ interface{}) error {
	return nil
}

func (_ *Connection) SetExecutionWithTransaction(_ bool) error {
	return nil
}

func (_ *Connection) Write(_ []string) ([]WriteResult, error) {
	return nil, nil
}

func (_ *Connection) WriteContext(_ context.Context, _ []string) ([]WriteResult, error) {
	return nil, nil
}

func (_ *Connection) WriteOne(_ string) (WriteResult, error) {
	return WriteResult{}, nil
}

func (_ *Connection) WriteOneContext(_ context.Context, _ string) (WriteResult, error) {
	return WriteResult{}, nil
}

func (_ *Connection) WriteOneParameterized(_ ParameterizedStatement) (WriteResult, error) {
	return WriteResult{}, nil
}

func (_ *Connection) WriteOneParameterizedContext(_ context.Context, _ ParameterizedStatement) (WriteResult, error) {
	return WriteResult{}, nil
}

func (_ *Connection) WriteParameterized(_ []ParameterizedStatement) ([]WriteResult, error) {
	return nil, nil
}

func (_ *Connection) WriteParameterizedContext(_ context.Context, _ []ParameterizedStatement) ([]WriteResult, error) {
	return nil, nil
}

func Open(_ string) (*Connection, error) {
	return nil, nil
}

type ParameterizedStatement struct {
	Query     string
	Arguments []interface{}
}

type QueryResult struct {
	Err    error
	Timing float64
}

func (_ *QueryResult) Columns() []string {
	return nil
}

func (_ *QueryResult) Map() (map[string]interface{}, error) {
	return nil, nil
}

func (_ *QueryResult) Next() bool {
	return false
}

func (_ *QueryResult) NumRows() int64 {
	return 0
}

func (_ *QueryResult) RowNumber() int64 {
	return 0
}

func (_ *QueryResult) Scan(_ ...interface{}) error {
	return nil
}

func (_ *QueryResult) Slice() ([]interface{}, error) {
	return nil, nil
}

func (_ *QueryResult) Types() []string {
	return nil
}

type RequestResult struct {
	Err   error
	Query *QueryResult
	Write *WriteResult
}

type WriteResult struct {
	Err          error
	Timing       float64
	RowsAffected int64
	LastInsertID int64
}
