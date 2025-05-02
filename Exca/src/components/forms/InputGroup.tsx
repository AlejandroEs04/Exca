import { ChangeEvent, useEffect, useState } from "react"

export type Option = {
    label: string
    value: string | number
}

export type PushEvent = {
    target: {
        name: string
        value: string | number
    }
}

type InputGroupProps = {
    id?: string
    name: string
    value: string | number
    type?: 'text' | 'number' | 'email' | 'password' | 'date' | 'tel' | 'currency'
    placeholder: string
    label: string
    options?: Option[]
    disable?: boolean
    limit?: number | null
    className?: string | null
    onChangeFnc?: (e: ChangeEvent<HTMLInputElement> | PushEvent) => void
    isHorizontal?: boolean
}

export default function InputGroup({
        name, 
        id = name, 
        value, 
        type = 'text', 
        placeholder,
        label,
        onChangeFnc, 
        options = [],
        disable = false, 
        limit = null,
        className = null,
        isHorizontal = false
    } : InputGroupProps) 
{
    const [show, setShow] = useState(false)
    const [isError, setIsError] = useState<string | null>(null)
    const [optionsFiltered, setOptionsFiltered] = useState<Option[]>(options)

    const onPushOption = (value: string) => {
        const e : PushEvent = {
            target: {
                name,
                value
            }
        }
        if(onChangeFnc != null)
            onChangeFnc(e);
    }

    const onChange = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        if(limit) {
            if(limit < +e.target.value) {
                setIsError('Este valor supera el limite')
            } else {
                setIsError(null)
            }
        }
        if(onChangeFnc != null) {
            onChangeFnc(e);

        }

        if(e.target.value === '') {
            setOptionsFiltered(options)
            return
        }

        const filtered = options.filter(option => option.label.toLowerCase().includes((e as ChangeEvent<HTMLInputElement>).target.value.toLowerCase()))
        setOptionsFiltered(filtered)
    }

    function formatToCurrency(value: string | number): string {
        const num = typeof value === 'number' ? value : parseFloat(String(value).replace(/[^0-9.]/g, ''))
        if (isNaN(num)) return ''
        return new Intl.NumberFormat('es-MX', {
            style: 'currency',
            currency: 'MXN',
            minimumFractionDigits: 2,
        }).format(num)
    }
    useEffect(() => {
        if (type === 'currency' && typeof value === 'number') {
            const formatted = formatToCurrency(value)
            const e: PushEvent = {
                target: {
                    name,
                    value: formatted
                }
            }
            if (onChangeFnc) onChangeFnc(e)
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [type])
    
    return (
        <div className={isHorizontal ? 'condition-container' : `${className} input-group`}>
            <label htmlFor={id}>{label}</label>
            <input 
                disabled={disable}
                onFocus={() => {
                    setShow(true)
                    if (type === 'currency') {
                        const raw = String(value).replace(/[^0-9.]/g, '')
                        const e: PushEvent = {
                            target: {
                                name,
                                value: raw
                            }
                        }
                        if (onChangeFnc) onChangeFnc(e)
                    }
                }}                
                onBlur={() => {
                    setTimeout(() => setShow(false), 100)
                    if (type === 'currency') {
                        const formatted = formatToCurrency(value)
                        const e: PushEvent = {
                            target: {
                                name,
                                value: formatted
                            }
                        }
                        if (onChangeFnc) onChangeFnc(e)
                    }
                }}
                type={type} 
                name={name} 
                id={id} 
                value={value} 
                placeholder={placeholder}
                onChange={onChange}
                autoComplete="off"
                className={`${isError ? 'input-error' : ''}`}
            />

            {isError && (
                <p className="input-error-message">{isError}</p>
            )}

            {optionsFiltered.length > 0 && show && (
                <div className="input-options">
                    {optionsFiltered.map(option => (
                        <button type="button" key={option.value} onMouseDown={() => onPushOption(option.label)}>{option.label}</button>
                    ))}
                </div>
            )}
        </div>
    )
}
