# Defined in - @ line 1
function bt --wraps='go build ./... && go test ./...' --description 'alias bt=go build ./... && go test ./...'
  go build ./... && go test ./... $argv;
end
